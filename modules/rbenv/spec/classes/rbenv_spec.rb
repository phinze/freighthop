require 'spec_helper'

describe 'rbenv' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'standard resources' do
    it { should contain_package('rbenv') }

    it {
      should contain_file('/etc/profile.d/rbenv.sh').with(
        :mode    => '0755',
        :content => /RBENV_ROOT="\/usr\/lib\/rbenv"/
      )
    }
  end

  context 'global_version uses default from rbenv::global' do
    it { should contain_class('rbenv::global') }
  end

  context 'global_version is 1.2.3' do
    let(:params) {{
      :global_version => '1.2.3',
    }}

    it { should contain_class('rbenv::global') }
  end
end
