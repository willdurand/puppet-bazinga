require 'spec_helper'

describe 'bazinga::roles::apache_fpm', :type => :class do
  let(:title) { 'bazinga::roles::php' }
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('bazinga::roles::apache') \
    .with_apache_user('www-data') \
    .with_apache_group('www-data')
  }

  it { should contain_package('libapache2-mod-fastcgi') }

  it { should contain_exec('a2enmod-actions') }

  it { should contain_exec('a2enmod-fastcgi') }

  it { should contain_package('php5-fpm') }

  it { should contain_service('php5-fpm') }

  it { should contain_file('/etc/php5/fpm/') \
    .with_ensure('directory')
  }

  it { should contain_file('/etc/php5/fpm/conf.d') \
    .with_ensure('link')
  }

  it { should contain_file('/etc/php5/fpm/pool.d') \
    .with_ensure('directory')
  }

  it { should contain_file('/etc/php5/fpm/php.ini') \
    .with_content(nil) \
    .with_source('puppet:///modules/bazinga/php/default.ini')
  }

  it { should contain_file('/etc/php5/fpm/php-fpm.conf') }

  describe 'with custom php.ini (fpm) source' do
    let(:params) {{
      :fpm_ini_source => 'fpm.ini'
    }}

    it { should contain_file('/etc/php5/fpm/php.ini') \
      .with_content(nil) \
      .with_source('fpm.ini')
    }
  end
end
