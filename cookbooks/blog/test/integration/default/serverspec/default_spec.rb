require 'spec_helper'

describe 'blog::default' do
  describe service('apache2') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }

    describe port(80) do
      it { is_expected.to be_listening }
    end
  end

  describe service('mysql-default') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }

    describe port(3306) do
      it { is_expected.to be_listening }
    end
  end

  context 'wordpress installed' do
    describe command('wget -qO-  localhost') do
      its(:stdout) { should match /WordPress &rsaquo; Installation/ }
    end
  end
end
