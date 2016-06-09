require 'spec_helper'

pname = 'sopel';

describe package 'runit' do
  it { should be_installed }
end

describe file '/bin/false' do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end

describe file '/etc/shells' do
  its(:content) { should match '/bin/false' }
end

describe user "#{pname}" do
  it { should exist }
  it { should belong_to_group "#{pname}" }
  it { should have_home_directory "/home/#{pname}" }
  it { should have_login_shell '/bin/false' }
end

describe user "#{pname}-log" do
  it { should exist }
  it { should belong_to_group "#{pname}" }
  it { should have_home_directory '' }
  it { should have_login_shell '/bin/false' }
end

dirs = [
  "/etc/sv/#{pname}/env",
  "/etc/sv/#{pname}/log",
  "/var/run/sv.#{pname}",
  "/var/run/sv.#{pname}-log" ]

dirs.each do | dir |
  describe file dir do
    it { should exist }
  end
end

describe file "/var/log/sv.#{pname}-log" do
  it { should exist }
  it { should be_owned_by "#{pname}-log" }
  it { should be_grouped_into "#{pname}-log" }
end

symlinks = {
  "/etc/sv/#{pname}/supervise" => "/run/sv.#{pname}",
  "/etc/sv/#{pname}/log/supervise" => "/run/sv.#{pname}-log",
  "/etc/sv/#{pname}/log/main" => "/var/log/sv.#{pname}-log",
  "/etc/service/#{pname}" => "/etc/sv/#{pname}" }

symlinks.each do | dest, src |
  describe file dest do
    it { should exist }
    it { should be_symlink }
    it { should be_linked_to src}
  end
end

runfiles = [
  "/etc/sv/#{pname}/run",
  "/etc/sv/#{pname}/log/run" ]

runfiles.each do | runfile |
  describe file runfile do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 744 }
  end
end

envfiles = [
  "/etc/sv/#{pname}/env/LANG",
  "/etc/sv/#{pname}/env/CONFIG" ]

envfiles.each do | envfile |
  describe file envfile do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end
