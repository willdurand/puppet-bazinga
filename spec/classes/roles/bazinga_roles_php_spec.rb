require 'spec_helper'

describe 'bazinga::roles::php', :type => :class do
  let(:title) { 'bazinga::roles::php' }
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('php') }
  it { should contain_class('composer') }

  it { should_not contain_php__conf('default') \
    .with_source('puppet:///modules/bazinga/php/default.ini')
  }

  it { should contain_package('php5-intl') }
  it { should contain_php__conf('intl') }
  it { should contain_file('intl-symlink') \
    .with_ensure('absent')
  }

  it { should contain_package('php5-curl') }
  it { should contain_php__conf('curl') }
  it { should contain_file('intl-symlink') \
    .with_ensure('absent')
  }

  it { should contain_php__module('apc') }
end
