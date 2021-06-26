
$localfilepath = "C:\TEMP\azureTest.vhd"
$ResourceGroup = "RG-Histadrut-IT"
$diskname = "vhduploadtest"

#$vhd = Get-VHD -Path $localfilepath
#if (($vhd.Size % 1MB) -ne 0)
#{
#    exit
#}
#$vhd.FileSize - $vhd.Size
#512



Connect-AzAccount -TenantID 759d202d-996d-4c97-8a86-4ade85fb1d47

$vhdSizeBytes = (Get-Item $localfilepath).length

$diskconfig = New-AzDiskConfig -SkuName 'StandardSSD_LRS' -OsType 'Windows' -UploadSizeInBytes $vhdSizeBytes -Location "northeurope" -CreateOption 'Upload' -HyperVGeneration "V2"

New-AzDisk -ResourceGroupName $ResourceGroup -DiskName $diskname -Disk $diskconfig

$diskSas = Grant-AzDiskAccess -ResourceGroupName $ResourceGroup -DiskName $diskname -DurationInSecond 86400 -Access 'Write'

$disk = Get-AzDisk -ResourceGroupName $ResourceGroup -DiskName $diskname

.\azcopy.exe copy $localfilepath $diskSas.AccessSAS --blob-type PageBlob

Revoke-AzDiskAccess -ResourceGroupName $ResourceGroup -DiskName $diskname