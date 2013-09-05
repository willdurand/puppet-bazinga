require 'spec_helper'

describe 'bazinga::roles::base', :type => :class do
  let(:title) { 'bazinga::roles:base' }
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('apt') }
  it { should contain_class('ntp') }

  it { should contain_package('openssh-server').with_ensure('present') }
  it { should contain_service('ssh').with_ensure('running') }

  it { should contain_package('nfs-common').with_ensure('absent') }

  describe 'with vagrant = true' do
    let(:params) {{ :vagrant => true }}

    it { should contain_package('nfs-common').with_ensure('present') }
  end
end
