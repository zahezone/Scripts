function ConnectToTennant {
    param (
        [Parameter (Mandatory = $true)] [String]$TenantID
    )
    
    $ApplicationId         = '128860ea-76fa-4a64-a570-5bb12acfe05a'
    $ApplicationSecret     = 'CpGpZfmczL8we5szeg/CyvH4lKg3YMCI+HlFoWJRV8A=' | Convertto-SecureString -AsPlainText -Force
    #$TenantID              = '85881429-e6fd-450e-aee4-f1e6a24aa384'
    $RefreshToken          = '0.AUEALDIlvn-Ew0agmRsDZX7xNupgiBL6dmRKpXBbsSrP4FpBAHU.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P9DA8JMCG_-t_RmOsJfmL1Tds7h8wEOEIFro-n9s83pqbyjWr4X2g7BedBtx1rjXhe9VlaSTR7QbdsOl8TYAboMFkC5idP5d4tOFo7TS8Ha57xf_gv09YaQrsObbcYXSzBzg_-M_M1M6yaVWVTINVwA8FU-N45HQ_XLW2Fhm-PIvoSZzb3_OoVEwrDb73jb-ysUcBHJW85UfiZIvqjX8REgAVUJyQiIxFxOAoJTmFFSFNGc74-8cGV7YH0BIAIR6vU2H1LdbwDRbrnBF_EP83ffTU8ZxTF8dGPbj71xw86rs3Pq2wQz6w2v49mxb8p5-T9ysJODXZiL5HWyUDVmOSyhWajtN4aww6bgacazssqS_cYePzRTfbU1usfgrxkt2jyAWlOFf9vxH5nFX6yyT1U496rb7VYgch19kHsz-usx4T_XYVacTNHbzIL71MNhgq7nI6UVN4XErTaaV1VX3qF74dIlmB4vod6Oi1nO5PEIlxBoOCaVLRpoPTXuEwmaaTH4vbkU-VpnP4QhU3eAznPcLS6buw2vrxWx_f8zXCZyFAzKioE_zWSKTT0ca0V9qnQQU3_SjS8uhntftZPzvUbqM2Qrw7S_cL96AQrGoB2nFqKhL5zS9Abl28xx-3ramXdCf9mXAyxUWSy1cYg6Q43cEu3Dcvvwe-ApxtX__76At5MgMCWGxq8g0hUdPqZyiLqLxnwPFwuONFqSuvHqryRndg_qxNmGJ1XaxOZRV7r5Q3W6P8hT2BC90X6znr-ENn_yF131CijhoRnBVP65_ANn9BaS3xd2VN5dq_hdxp7-7GkzO3F7fDZQ_nQI_26JEiPQhY_aCseReYNlP7Ig8pbpH77jmJmR'
    $ExchangeRefreshToken  = '0.AUEALDIlvn-Ew0agmRsDZX7xNhY8x6Djp2RFmpUr30c4NxZBAHU.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P8r4FjMcpnaSMt86xcC8heLeCtlDLKiC9GNPuleLW0dhyj3dWaocPLb6-l2VGL9FaUxCeVzg3ACYYuixfiiB3MBq9lDfKm6BuW6pwnQlTrLEjMMslFh5O2awb3V7M3C240O3hIv-cCcr2MEfdue0__GlSO4G-P_haPvGBQAoJnO7pi3xIV6IAREztuAcRFHnVURAGvG-lP8P0TDS5xqXCmlDI5U9pmYaEdYko8SFY8dLUUronG0KXTJ9XorT2Yx8048u1iKgl_TmIesKGcbulGnsZx6T07KEzaZV9Aq_JZw8cSXg0otIvttgiW3OFKiJIAeBNkZb_9qx710Oc1VkQFA7Ixw0BWzQBX74E35uIg65H6jpgOuFe2q_GQYzB7TI_Pe-s7o33KEw9pBb-yeSyw8E9DP-Pmb2ZgHjw7eybjtd8ht-JEUzq-MtoeYfkFjSIDRIhmOjE9uehLsx1SiAGaWbh2ZjkwWfVcOOya93nKYgPH09A4OgGxd4oKvoUWxwouzrVl6dmBUm_WXsXnFnVk5hBIS1cyes2S57pCn-Wbmg80rJ-HvFndDe_NjrBkcADubMajP-tohuJg3xpp1hhFRcP62PIaz6j9KwyaZOyFTN99mdzDI8mX5MLQV_3K6qmtqfOZ4upqsWbjOFA38b9ugYIegwKdNhCD5DgFTEcMhtZJMLKqrnxo3f5UjVCEj5RSdbqK22RySdRhag2oza3VV179291q7A9CAOhAFWg8W1s_axIo3MvdmraQ9T5rQGf9rXzDxOy9pXORdatY5r87Mz65dxd-q-_Nqwp2trb2gkCu0BLPATIv2LC3LbiVLDcU64P1L7Q6QutA'
    $credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)

    $aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal -Tenant $tenantID
    $graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default' -ServicePrincipal -Tenant $tenantID

    Connect-AzureAD -AadAccessToken $aadGraphToken.AccessToken -AccountId 'admin.sholzberger@ip2me.com.auget' -MsAccessToken $graphToken.AccessToken -TenantId $tenantID
}

ConnectToTennant -TenantID "85881429-e6fd-450e-aee4-f1e6a24aa384"