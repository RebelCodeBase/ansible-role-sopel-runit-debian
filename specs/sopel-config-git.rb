require 'spec_helper'

pname = 'sopel'
homedir = "/home/#{pname}"
configdir = "#{homedir}/.sopel"

host = ENV['TARGET_HOST']

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
