require 'spec_helper'

packages = %w( git python3 ipython3 python3-feedparser )

packages.each do | package |
  describe package package do
    it { should be_installed }
  end
end

pname = 'sopel'
homedir = "/home/#{pname}"
botdir = "#{homedir}/sopel"
moddir = "#{homedir}/modules"
configdir = "#{homedir}/.sopel"
custommoddir = "#{configdir}/modules"

dirs = [ homedir, botdir, moddir, configdir, custommoddir ]

dirs.each do | dir |
  describe file dir do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by "#{pname}" }
    it { should be_grouped_into "#{pname}" }
  end
end

