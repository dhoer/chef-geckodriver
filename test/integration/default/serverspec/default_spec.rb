require 'serverspec_helper'

describe 'selenium::geckodriver' do
  if os[:family] == 'windows'
    describe file('C:/geckodriver/geckodriver.exe') do
      it { should be_file }
    end
  else
    describe file('/usr/bin/geckodriver') do
      it { should be_symlink }
    end
  end
end
