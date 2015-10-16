require 'rake'
require 'rspec/core/rake_task'
require 'fileutils'

task :spec            => 'spec:all'
task :specwin7        => 'spec:win7'
task :specwin2008     => 'spec:win2008'
task :specwin2012R2     => 'spec:win2012R2'
task :specwin2012R2Core => 'spec:win2012R2Core'

task :clean do
  FileUtils.rm_rf "output-virtualbox-windows-iso"
  FileUtils.rm_rf "packer_cache"
  FileUtils.rm_rf ".vagrant"
end

task :vagrant do
  system("vagrant up")
end

task :destroy do
  system("vagrant destroy -f")
end

desc 'Build all boxes and ServerSpec them'
task 'build' => [:build7, :build2008, :build2012R2, :build2012R2Core, :vagrant, :spec, :destroy ]

task :build7 do
  if !File.exist? '/box/vagrant-windows7.box'
    win7iso = Dir.glob(Dir.pwd + "/isos/win7/*.iso", File::FNM_CASEFOLD)[0]
    if !File.exist? "#{win7iso}"
      fail "Error: Missing ISO file"
    else
      system("packer build -var iso=\"#{win7iso}\" win7/win7.json ")
    end
  else
    printf("vagrant-windows7.box already exists moving on \n")
  end
end

task :build2008 do
  if !File.exist? '/box/vagrant-windows2008.box'
    win2008iso = Dir.glob(Dir.pwd + "/isos/win2008/*.iso", File::FNM_CASEFOLD)[0]
    if !File.exist? "#{win2008iso}"
      fail "Error: Missing ISO file"
    else
      system("packer build -var iso=\"#{win2008iso}\" win2008/win2008.json ")
    end
  else
    printf("vagrant-windows2008.box already exists moving on \n")
  end
end

task :build2012R2 do
  if !File.exist? '/box/vagrant-windows2012R2.box'
    win2012R2iso = Dir.glob(Dir.pwd + "/isos/win2012R2/*.iso", File::FNM_CASEFOLD)[0]
    if !File.exist? "#{win2012R2iso}"
      fail "Error: Missing ISO file"
    else
      system("packer build -var iso=\"#{win2012R2iso}\" win2012R2/win2012R2.json ")
    end
  else
    printf("vagrant-windows2012R2.box already exists moving on \n")
  end
end

task :build2012R2Core do
  if !File.exist? '/box/vagrant-windows2012R2Core.box'
    win2012R2Coreiso = Dir.glob(Dir.pwd + "/isos/win2012R2/*.iso", File::FNM_CASEFOLD)[0]
    if !File.exist? "#{win2012R2Coreiso}"
      raise "Error: Missing ISO file"
    else
      system("packer build -var iso=\"#{win2012R2Coreiso}\" win2012R2Core/win2012R2Core.json ")
    end
  else
    printf("vagrant-windows2012R2Core.box already exists moving on \n")
  end
end

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end
