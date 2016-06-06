require 'spec_helper'

describe package 'runit' do
  it { should be_installed }
end

describe user 'sopel' do
  it { should exist }
  it { should belong_to_group 'sopel' }
  it { should have_home_directory '/home/sopel' }
  it { should have_login_shell '/bin/false' }
end

describe user 'sopel-log' do
  it { should exist }
  it { should belong_to_group 'sopel' }
  it { should have_home_directory '' }
  it { should have_login_shell '/bin/false' }
end
