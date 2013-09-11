require 'spec_helper'

describe 'rbenv::version' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'Version 1.2.3-p456' do
    let(:title) { '1.2.3-p456' }
    let(:exec_title) { 'install bundler for 1.2.3-p456' }
    let(:cmd_prefix) { /^\/usr\/bin\/env -uRUBYOPT -uBUNDLE_GEMFILE -uGEM_HOME -uGEM_PATH \/usr\/bin\/rbenv exec gem/ }

    context 'ruby version' do
      it {
        should contain_package('rbenv-ruby-1.2.3-p456').with(
          :notify  => "Exec[#{exec_title}]",
          :require => 'Class[Rbenv]'
        )
      }
    end

    context 'rehash' do
      it { should contain_rbenv__rehash('1.2.3-p456') }
      it { should contain_exec(exec_title).with_notify('Rbenv::Rehash[1.2.3-p456]') }
    end

    context 'bundler' do
      it 'should set env vars for rbenv' do
        should contain_exec(exec_title).with(
          :environment => [
            'RBENV_ROOT=/usr/lib/rbenv',
            'RBENV_VERSION=1.2.3-p456',
          ]
        )
      end

      context 'bundler_version not set (default)' do
        it {
          should contain_exec(exec_title).with(
            :command => /#{cmd_prefix} install bundler -v '>= 0'$/,
            :unless  => /#{cmd_prefix} query -i -n bundler -v '>= 0'$/
          )
        }
      end

      context 'bundler_version 8.9.0' do
        let(:params) {{
          :bundler_version => '8.9.0'
        }}

        it {
          should contain_exec(exec_title).with(
            :command => /#{cmd_prefix} install bundler -v '8.9.0'$/,
            :unless  => /#{cmd_prefix} query -i -n bundler -v '8.9.0'$/
          )
        }
      end
    end
  end
end
