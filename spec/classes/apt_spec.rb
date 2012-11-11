require 'spec_helper'

describe 'bazinga::apt', :type => :class do
  let(:title) { 'bazinga::apt' }

  describe 'with Debian as OS family' do
    let(:facts) {{ :osfamily => 'Debian' }}

    it { should contain_apt__source('debian') }
    it { should contain_apt__source('dotdeb') }
  end

  describe 'with another OS family' do
    let(:facts) {{ :osfamily => 'Redhat' }}

    it { should_not contain_apt__source('debian') }
    it { should_not contain_apt__source('dotdeb') }
  end
end
