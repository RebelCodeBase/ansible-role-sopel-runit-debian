pname = 'sopel'
homedir = "/home/#{pname}"
botdir = "#{homedir}/sopel"
moddir = "#{homedir}/modules"
configdir = "#{homedir}/.sopel"
custommoddir = "#{configdir}/modules"
configfile = 'default.cfg'

packages = %w( git python3 ipython3 python3-feedparser )

packages.each do | package |
  describe package package do
    it { should be_installed }
  end
end

dirs = [ homedir, botdir, moddir, configdir, custommoddir ]

dirs.each do | dir |
  describe file dir do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by "#{pname}" }
    it { should be_grouped_into "#{pname}" }
  end
end

git_remote_botdir = "git --git-dir=#{botdir}/.git remote --verbose | grep fetch | cut -d ' ' -f 1 | cut -f 2"
describe "Git remote \"#{botdir}/.git\"" do
  it 'should be https://github.com/sopel-irc/sopel.git' do
    sopel_git_remote_botdir = command(git_remote_botdir).stdout.chomp
    expect(sopel_git_remote_botdir).to eq 'https://github.com/sopel-irc/sopel.git'
  end
end

describe file "#{botdir}/sopel.py" do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by "#{pname}" }
  it { should be_grouped_into "#{pname}" }
  it { should be_mode 744 }
end

git_remote_rssdir = "git --git-dir=#{moddir}/sopel-rss/.git remote --verbose | grep fetch | cut -d ' ' -f 1 | cut -f 2"
describe "Git remote \"#{moddir}/sopel-rss/.git\"" do
  it 'should be https://github.com/f4bio/sopel-rss.git' do
    sopel_git_remote_rssdir = command(git_remote_rssdir).stdout.chomp
    expect(sopel_git_remote_rssdir).to eq 'https://github.com/rebelcodebase/sopel-rss.git'
  end
end

describe file "#{custommoddir}/rss.py" do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to "#{moddir}/sopel-rss/rss.py" }
end
