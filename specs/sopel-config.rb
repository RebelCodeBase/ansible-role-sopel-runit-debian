pname = 'sopel'
homedir = "/home/#{pname}"
configdir = "#{homedir}/.sopel"
configfile = 'default.cfg'

describe file "#{configdir}/#{configfile}" do
  it { should exist }
  it { should be_file }
  it { should be_owned_by "#{pname}" }
  it { should be_grouped_into "#{pname}" }
  it { should be_mode 644 }
end
