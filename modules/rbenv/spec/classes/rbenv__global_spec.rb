require 'spec_helper'

# Focus on rbenv::global proxy of rbenv
describe 'rbenv' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}
  let(:file_path) { '/usr/lib/rbenv/version' }

  context 'when version is default, system' do
    it {
      should contain_file(file_path).with(
        :content => "system\n",
        :require => nil
      )
    }
  end

  context 'when version is 1.2.3' do
    let(:params) {{
      :global_version => '1.2.3',
    }}

    it {
      should contain_file(file_path).with(
        :content => "1.2.3\n",
        :require => 'Rbenv::Version[1.2.3]'
      )
    }
  end
end
