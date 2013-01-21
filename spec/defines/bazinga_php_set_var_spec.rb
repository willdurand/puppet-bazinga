require 'spec_helper'

describe 'bazinga::php::set_var', :type => :define do
  let(:title) { 'bazinga::php::set_var' }
  let(:facts) { {
    :osfamily => 'Debian'
  } }

  describe 'with name and value parameters' do
    let(:params) { {
      :name     => 'post_max_size',
      :value    => '500M',
      :file_ini => '/etc/php5/conf.d/default.ini'
    } }

    #it { should contain_exec('bazinga_php_set_var_default.ini_post_max_size') \
    #  .with_command("sed -i 's/^;*[[:space:]]*post_max_size[[:space:]]*=.*$/post_max_size = 500M/g' /etc/php5/conf.d/default.ini")
    #}
  end

  describe 'with a given file name' do
    let(:params) { {
      :name     => 'post_max_size',
      :value    => '500M',
      :file_ini => 'my_file.ini',
    } }

    it { should contain_exec('bazinga_php_set_var_my_file.ini_post_max_size') \
      .with_command("sed -i 's/^;*[[:space:]]*post_max_size[[:space:]]*=.*$/post_max_size = 500M/g' my_file.ini")
    }
  end
end
