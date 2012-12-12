require 'spec_helper'

describe 'bazinga::apt', :type => :class do
  let(:title) { 'bazinga::apt' }

  describe 'with Debian' do
    let(:facts) {{ :operatingsystem => 'Debian' }}

    it { should contain_apt__source('debian') }
    it { should contain_apt__source('dotdeb') }
    it { should_not contain_apt__source('ubuntu') }
  end

  describe 'with Ubuntu' do
    let(:facts) {{ :operatingsystem => 'Ubuntu' }}

    it { should_not contain_apt__source('debian') }
    it { should_not contain_apt__source('dotdeb') }
    it { should contain_apt__source('ubuntu') }
  end

  describe 'with another OS' do
    let(:facts) {{ :operatingsystem => 'Redhat' }}

    it { should_not contain_apt__source('debian') }
    it { should_not contain_apt__source('dotdeb') }
    it { should_not contain_apt__source('ubuntu') }
  end
end
