require 'spec_helper'

describe command('Get-ExecutionPolicy') do
  its(:stdout) { should match /Bypass/ }
  its(:exit_status) { should eq 0 }
end

describe command ('choco') do
  its(:stdout) { should contain('Chocolatey') }
end

describe command ('git --version') do
  its(:stdout) { should contain('git version') }
end

describe command ('puppet') do
  its(:stdout) { should contain('puppet help') }
end

describe command ('chef-client --version') do
  its(:stdout) { should contain('Chef:') }
end

describe service('VBoxService') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
  it { should have_start_mode("Automatic") }
end
