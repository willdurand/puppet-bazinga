require 'spec_helper'

describe 'bazinga::php::compile_ext', :type => :define do
  let(:title) { 'bazinga::php::compile_ext' }
  let(:facts) { {
    :osfamily => 'Debian'
  } }

  let(:params) { {
    :name       => 'redis',
    :repository => 'git://github.com/nicolasff/phpredis.git',
  } }

  it { should contain_exec('bazinga-php-compile-ext-redis-download') \
    .with_command('git clone git://github.com/nicolasff/phpredis.git /tmp/redis')
  }

  it { should contain_exec('bazinga-php-compile-ext-redis-phpize') \
    .with_command('phpize') \
    .with_cwd('/tmp/redis')
  }

  it { should contain_exec('bazinga-php-compile-ext-redis-configure') \
    .with_command('sh configure') \
    .with_cwd('/tmp/redis')
  }

  it { should contain_exec('bazinga-php-compile-ext-redis-install') \
    .with_command('make && make install') \
    .with_cwd('/tmp/redis')
  }

  it { should contain_file('bazinga-php-compile-ext-redis-config-file') \
    .with_content("; Managed by Puppet\nextension=redis.so\n")
  }

  it { should contain_exec('bazinga-php-compile-ext-redis-clean') \
    .with_command('rm -rf /tmp/redis')
  }

  describe 'with configure flags' do
    let(:params) { {
      :name            => 'redis',
      :repository      => 'git://github.com/nicolasff/phpredis.git',
      :configure_flags => '--enable-redis-igbinary'
    } }

    it { should contain_exec('bazinga-php-compile-ext-redis-configure') \
      .with_command('sh configure --enable-redis-igbinary') \
      .with_cwd('/tmp/redis')
    }
  end
end
