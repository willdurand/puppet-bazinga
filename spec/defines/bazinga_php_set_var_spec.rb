require 'spec_helper'

describe 'bazinga::php::set_var', :type => :define do
  let(:title) { 'bazinga::php::set_var' }
  let(:facts) { {
    :osfamily => 'Debian'
  } }

  let(:params) { {
    :name     => 'post_max_size',
    :value    => '500M',
    :file_ini => 'my_file.ini',
  } }

  it { should contain_exec('bazinga_php_set_var_my_file.ini_post_max_size') \
    .with_command("sed -i 's/^;*[[:space:]]*post_max_size[[:space:]]*=.*$/post_max_size = 500M/g' my_file.ini") \
    .with_notify(/^undef/)
  }

  describe 'with php::fpm::service defined' do
    let(:params) { {
      :name     => 'post_max_size',
      :value    => '500M',
      :file_ini => 'my_file.ini',
    } }

    let(:pre_condition) { "include bazinga::roles::apache_fpm\ninclude bazinga::roles::php" }

    it { should contain_exec('bazinga_php_set_var_my_file.ini_post_max_size') \
      .with_command("sed -i 's/^;*[[:space:]]*post_max_size[[:space:]]*=.*$/post_max_size = 500M/g' my_file.ini") \
      .with_notify(/^Class/)
    }
  end
end
