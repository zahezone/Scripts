#Parameters
$OneDriveSiteURL = "https://rbcducentis-my.sharepoint.com/personal/dnebauer_qcoal_com_au"
$DownloadPath ="C:\Temp\OneDriveBackup"
 
Try {
    #Connect to OneDrive site
    Connect-PnPOnline $OneDriveSiteURL 
    $Web = Get-PnPWeb
 
    #Get the "Documents" library where all OneDrive files are stored
    $List = Get-PnPList -Identity "Documents"
  
    #Get all Items from the Library - with progress bar
    $global:counter = 0
    $ListItems = Get-PnPListItem -List $List -PageSize 500 -Fields ID -ScriptBlock { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete `
                ($global:Counter / ($List.ItemCount) * 100) -Activity "Getting Items from OneDrive:" -Status "Processing Items $global:Counter to $($List.ItemCount)";}
    Write-Progress -Activity "Completed Retrieving Files and Folders from OneDrive!" -Completed
  
    #Get all Subfolders of the library
    $SubFolders = $ListItems | Where {$_.FileSystemObjectType -eq "Folder" -and $_.FieldValues.FileLeafRef -ne "Forms"}
    $SubFolders | ForEach-Object {
        #Ensure All Folders in the Local Path
        $LocalFolder = $DownloadPath + ($_.FieldValues.FileRef.Substring($Web.ServerRelativeUrl.Length)) -replace "/","\"
        #Create Local Folder, if it doesn't exist
        If (!(Test-Path -Path $LocalFolder)) {
                New-Item -ItemType Directory -Path $LocalFolder | Out-Null
        }
        Write-host -f Yellow "Ensured Folder '$LocalFolder'"
    }
  
    #Get all Files from the folder
    $FilesColl =  $ListItems | Where {$_.FileSystemObjectType -eq "File"}
  
    #Iterate through each file and download
    $FilesColl | ForEach-Object {
        $FileDownloadPath = ($DownloadPath + ($_.FieldValues.FileRef.Substring($Web.ServerRelativeUrl.Length)) -replace "/","\").Replace($_.FieldValues.FileLeafRef,'')
        Get-PnPFile -ServerRelativeUrl $_.FieldValues.FileRef -Path $FileDownloadPath -FileName $_.FieldValues.FileLeafRef -AsFile -force
        Write-host -f Green "Downloaded File from '$($_.FieldValues.FileRef)'"
    }
}
Catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}


#Read more: https://www.sharepointdiary.com/2021/09/how-to-download-all-files-from-onedrive-for-business.html#ixzz83uETOhpl