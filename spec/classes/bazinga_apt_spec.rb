require 'spec_helper'

describe 'bazinga::apt', :type => :class do
  let(:title) { 'bazinga::apt' }

  describe 'with Debian' do
    let(:facts) {{
      :operatingsystem => 'Debian',
      :lsbdistcodename => 'wheezy',
    }}

    it { should contain_apt__source('debian') }
    it { should contain_apt__source('dotdeb').with_release('wheezy') }
    it { should_not contain_apt__source('ubuntu') }
  end

  describe 'with Debian Squeeze' do
    let(:facts) {{
      :operatingsystem => 'Debian',
      :lsbdistcodename => 'squeeze',
    }}

    it { should contain_apt__source('debian') }
    it { should contain_apt__source('dotdeb').with_release('squeeze-php54') }
    it { should_not contain_apt__source('ubuntu') }
  end

  describe 'with Ubuntu' do
    let(:facts) {{
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'lucid'
    }}

    it { should_not contain_apt__source('debian') }
    it { should_not contain_apt__source('dotdeb') }
    it { should contain_apt__source('ubuntu').with_release('lucid') }
  end

  describe 'with another OS' do
    let(:facts) {{ :operatingsystem => 'Redhat' }}

    it { should_not contain_apt__source('debian') }
    it { should_not contain_apt__source('dotdeb') }
    it { should_not contain_apt__source('ubuntu') }
  end
end
