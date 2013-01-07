require 'spec_helper'

describe 'bazinga::php::phpsh', :type => :class do
  let(:title) { 'bazinga::php::phpsh' }

  it { should contain_exec('phpsh-download') }
  it { should contain_exec('phpsh-unpack') }
  it { should contain_exec('phpsh-install') }
end
