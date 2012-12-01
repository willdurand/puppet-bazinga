require 'spec_helper'

describe 'bazinga::roles::php', :type => :class do
  let(:title) { 'bazinga::roles::php' }
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('php') }
  it { should contain_class('composer') }

  it { should contain_php__conf('default') \
    .with_source('puppet:///modules/bazinga/php/default.ini') \
    .without_notify()
  }

  it { should contain_php__module('intl').without_notify() }
  it { should contain_php__module('curl').without_notify() }
  it { should contain_php__module('apc').without_notify() }
end
