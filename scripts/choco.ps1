#
# choco.ps1
#
# Install .net 4.0 if version lower than windows 8/2012 and higher than Windows XP (5,1)
# (Windows XP Pro x64 (5,2) should work). Chocolatey requires this .net and it will not install via
# winrm due to the fact that the .NET package contains MSU's that will not work over winrm. We
# can manually get around this by passing the /SkipMSUInstall to the .NET installer.
#
if([Environment]::OSVersion.Version -lt (new-object 'Version' 6,2) -and [Environment]::OSVersion.version -gt (new-object 'Version' 5,1))
{
  $url = "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
  $file = "dotNetFx40_Full_x86_x64.exe"
  $tempPath = "C:\Windows\Temp"
  $run = Join-Path $tempPath $file
  if(!(Test-Path($run)))
  {
    (New-Object System.Net.WebClient).DownloadFile($url, $run)
  } else {
    echo "==> $file already exists skipping download"
  }

  echo "==> running $run now"
  $exit = (Start-Process $run -ArgumentList "/q /SkipMSUInstall" -Wait -Passthru -verb runAs).ExitCode
  if($exit -ne 0)
  {
    echo "==> $file installed failed"
  }
  else
  {
    echo "==> $file install finished"
  }
}
#
#Install Chocolatey
#
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

#
# Legacy Chocolatey install with old .cmd file structure.
#
#iex ((new-object Net.WebClient).DownloadString('https://chocolatey.org/install-lastposhclient.ps1'))