#
# bootstrap.ps1
# install VBoxGuestAdditions, sdelete freespace, remove temp files, remove un-needed windows features.
#
$tempFolder = "C:\Windows\Temp\"
#
# Compact and Install VBoxAdditions
#
if(!(Test-Path (Join-Path $tempFolder "7z920-x64.msi")))
{
  (New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')
}

Start-Process "C:\Windows\Temp\7z920-x64.msi" -ArgumentList "/qb"

if(!(Test-Path (Join-Path $tempFolder "ultradefrag.zip")))
{
  (New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/ultradefrag/ultradefrag-portable-6.0.2.bin.amd64.zip', 'C:\Windows\Temp\ultradefrag.zip')
}

if(!(Test-Path (Join-Path $tempFolder "ultradefrag-portable-6.0.2.amd64\udefrag.exe")))
{
  Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "x C:\Windows\Temp\ultradefrag.zip -oC:\Windows\Temp" -Wait
}

if(!(Test-Path (Join-Path $tempFolder "SDelete.zip")))
{
  (New-Object System.Net.WebClient).DownloadFile('http://download.sysinternals.com/files/SDelete.zip', 'C:\Windows\Temp\SDelete.zip')
}

if(!(Test-Path (Join-Path $tempFolder "sdelete.exe")))
{
  Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "x C:\Windows\Temp\SDelete.zip -oC:\Windows\Temp" -Wait
}

if(!(Test-Path (Join-Path $tempFolder "VBoxGuestAdditions.iso")))
{
  echo "==> installing VBoxGuestAdditions"
  (New-Object System.Net.WebClient).DownloadFile('http://download.virtualbox.org/virtualbox/4.3.24/VBoxGuestAdditions_4.3.24.iso', 'C:\Windows\Temp\VBoxGuestAdditions.iso')
  Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "x C:\Windows\temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox" -Wait
  Start-Process -FilePath "certutil" -ArgumentList "-addstore -f ""TrustedPublisher"" C:\Windows\Temp\virtualbox\cert\oracle-vbox.cer" -Wait
  Start-Process (Join-Path $tempFolder "\virtualbox\VBoxWindowsAdditions.exe") -ArgumentList "/S" -Wait
  echo "==> VBoxGuestAdditions finished"
}

echo "==> running ultradefrag"
Start-Process -FilePath (Join-Path $tempFolder "ultradefrag-portable-6.0.2.amd64\udefrag.exe") -ArgumentList "--optimize --repeat C:" -Wait
echo "==> ultradefrag finished"

echo "==> running sdelete"
Start-Process -FilePath "C:\Windows\System32\reg.exe" -ArgumentList "ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f" -Wait
Start-Process -FilePath (Join-Path $tempFolder "sdelete.exe") -ArgumentList "-q -zC:" -Wait
echo "==> sdelete finsished"

echo "==> cleaning windows temp folder"
Remove-Item C:\Windows\Temp\* -Force -Recurse
echo "==> windows temp folder cleaned"

if([Environment]::OSVersion.Version -ge (new-object 'Version' 6,2))
{
  Get-WindowsFeature | ? { $_.InstallState -eq 'Available' } | Uninstall-WindowsFeature -Remove
}