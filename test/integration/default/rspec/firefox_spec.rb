require 'rspec_helper'
require 'rbconfig'

describe 'Firefox Grid' do
  before(:all) do
    # Selenium::WebDriver::Firefox::Binary.path = 'c:\\Program Files\\Mozilla Firefox\\firefox.exe'
    caps = Selenium::WebDriver::Remote::W3CCapabilities.firefox
    @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: caps)
  end

  after(:all) do
    @selenium.quit
  end

  res = if MAC || WINDOWS
          '1024 x 768'
        else
          '1280 x 1024' # xvfb
        end

  it "Should return display resolution of #{res}" do
    @selenium.get 'http://www.whatismyscreenresolution.com/'
    element = @selenium.find_element(:id, 'resolutionNumber')
    expect(element.text).to eq(res)
  end
end
