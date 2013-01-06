require 'spec_helper'

describe 'bazinga::roles::apache', :type => :class do
  let(:title) { 'bazinga::roles::apache' }
  let(:facts) {{ :osfamily => 'Debian' }}

  describe 'with Debian family' do
    it { should contain_user('www-data').with_ensure('present') }
    it { should contain_group('www-data').with_ensure('present') }
    it { should_not contain_file('/home/www-data/www') }

    describe 'with a given user' do
      let(:params) {{ :apache_user => 'foo' }}

      it { should contain_user('foo').with_ensure('present') }
      it { should contain_group('www-data').with_ensure('present') }

      it { should contain_file('/home/foo/www') \
        .with_ensure('directory') \
        .with_owner('foo') \
        .with_group('www-data')
      }
    end
  end

  describe 'with RedHat family' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    it { should contain_user('apache').with_ensure('present') }
    it { should contain_group('apache').with_ensure('present') }
    it { should_not contain_file('/home/apache/www') }

    describe 'with a given user' do
      let(:params) {{ :apache_user => 'foo' }}

      it { should contain_user('foo').with_ensure('present') }
      it { should contain_group('apache').with_ensure('present') }

      it { should contain_file('/home/foo/www') \
        .with_ensure('directory') \
        .with_owner('foo') \
        .with_group('apache')
      }
    end
  end

  describe 'with given user and group' do
    let(:params) {{ :apache_user => 'foo', :apache_group => 'bar' }}

    it { should contain_user('foo') \
      .with_ensure('present') \
      .with_groups('bar')
    }
    it { should contain_group('bar').with_ensure('present') }
    it { should contain_file('/home/foo/www') \
      .with_ensure('directory') \
      .with_owner('foo') \
      .with_group('bar')
    }
  end
end
