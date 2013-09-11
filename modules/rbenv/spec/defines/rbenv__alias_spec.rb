require 'spec_helper'

describe 'rbenv::alias' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context '1.2.3 to 1.2.3-p456' do
    let(:title) { '1.2.3' }
    let(:params) {{
      :to_version => '1.2.3-p456',
    }}

    it { 
      should contain_file('/usr/lib/rbenv/versions/1.2.3').with(
        :ensure  => 'link',
        :target  => '1.2.3-p456',
        :require => 'Rbenv::Version[1.2.3-p456]'
      )
    }
  end
end
