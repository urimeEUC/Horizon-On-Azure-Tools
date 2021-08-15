
#install addins
Install-Module -Name Az.Accounts -SkipPublisherCheck -Scope CurrentUser -Force
Install-Module -Name Az.Resources -SkipPublisherCheck -Scope CurrentUser -Force
Install-Module AzureAD -SkipPublisherCheck -Scope CurrentUser -Force
Import-Module Az.Accounts
Import-Module Az.Resources
Import-Module AzureAD


$directoryID = Read-Host "Insert Directory ID"
$Providers = "Microsoft.Authorization", "Microsoft.Compute" ,"Microsoft.DBforPostgreSQL", "Microsoft.KeyVault","Microsoft.Network", "Microsoft.Resources", "Microsoft.Storage"
#$directoryID = 759d202d-996d-4c97-8a86-4ade85fb1d47
$TenantID =

# Set-executionpolicy remotesigned

#Connect to Instant
#need to run from windows machine that is able to login to azure portal 


try{
Connect-AzAccount -TenantID $directoryID -ErrorAction Stop
#$Providers | ForEach-Object {Register-AzResourceProvider -ProviderNamespace $_}
}
catch
{
write-host "Unable to logon please verify DirectoryID , verify user has premission for the subscription" 

}




$appName = "WorkspaceONE App"
$appURI ="http://localhost:8000 "
Connect-AzureAD -TenantId  


