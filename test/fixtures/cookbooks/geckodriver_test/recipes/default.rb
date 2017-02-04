include_recipe 'java_se'
include_recipe 'selenium::hub'
include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

include_recipe 'mozilla_firefox'
include_recipe 'geckodriver'

if platform?('windows', 'mac_os_x')
  node.override['selenium']['node']['username'] = 'vagrant'
  node.override['selenium']['node']['password'] = 'vagrant'
end

node.override['selenium']['node']['capabilities'] = [
  {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    seleniumProtocol: 'WebDriver'
  }
]

include_recipe 'selenium::node'
