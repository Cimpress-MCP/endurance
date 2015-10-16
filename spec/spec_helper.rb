require 'serverspec'
require 'winrm'

set :backend, :winrm
set :os, :family => 'windows'

user = "vagrant"
pass = "vagrant"
endpoint = "http://#{ENV['TARGET_HOST']}:5985/wsman"

winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
winrm.set_timeout 5 * 60
Specinfra.configuration.winrm = winrm