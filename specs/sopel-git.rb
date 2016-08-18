pname = 'sopel'
homedir = "/home/#{pname}"
configdir = "#{homedir}/.sopel"
configfile = 'default.cfg'
host = ENV['TARGET_HOST']

describe file "#{configdir}/.gitignore" do
  it { should exist }
  it { should be_file }
  it { should be_owned_by "#{pname}" }
  it { should be_grouped_into "#{pname}" }
  it { should be_mode 644 }
  its(:sha256sum) { should eq 'fc147e236fac279b45679ce502225f922fd60fc2b7fc4783ab2a3c4849d78f25' }
end

git_status_configdir = "git --git-dir=#{configdir}/.git status"
describe "Directory \"#{configdir}/.git\"" do
  it 'should be a git repository' do
    sopel_git_status_configdir = command(git_status_configdir).exit_status
    expect(sopel_git_status_configdir).to eq 0
  end
end

git_config_user_name = "git --git-dir=#{configdir}/.git config user.name"
describe "Git config user.name in \"#{configdir}/.git\"" do
  it "should be #{pname}" do
    sopel_git_name_configdir = command(git_config_user_name).stdout.chomp
    expect(sopel_git_name_configdir).to eq "#{pname}"
  end
end

git_config_user_email = "git --git-dir=#{configdir}/.git config user.email"
describe "Git config user.email in \"#{configdir}/.git\"" do
  it "should be #{pname}@#{host}" do
    sopel_git_email_configdir = command(git_config_user_email).stdout.chomp
    expect(sopel_git_email_configdir).to eq "#{pname}@#{host}"
  end
end
