require 'serverspec_helper'

describe 'selenium::geckodriver' do
  if os[:family] == 'windows'
    describe file('C:/geckodriver/geckodriver.exe') do
      it { should be_file }
    end
  else
    describe command('geckodriver -V') do
      its(:stdout) { should match(/geckodriver/) }
    end
  end
end
