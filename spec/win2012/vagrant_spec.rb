require 'spec_helper'

describe command('Get-ExecutionPolicy') do
  its(:stdout) { should match /Bypass/ }
  its(:exit_status) { should eq 0 }
end

describe command ('choco') do
  its(:stdout) { should contain('Chocolatey') }
end

describe service('VBoxService') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
  it { should have_start_mode("Automatic") }
end