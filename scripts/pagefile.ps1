#
# pagefile.ps1
# remove pagefile as we build at 4096mb.
#
$Sys = GWMI Win32_ComputerSystem -EnableAllPrivileges
$Sys.AutomaticManagedPagefile = $False
$Sys.Put()

$PageFile = Get-WmiObject -query "select * from Win32_PageFileSetting where name='c:\\pagefile.sys'"
$PageFile.Delete()

#
# Example to set page file if needed
#
#$PageFile.InitialSize = (2 * 1024)
#$PageFile.MaximumSize = (2 * 1024)
#$PageFile.Put()
