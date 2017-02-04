# Selenium Gecko Driver Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/geckodriver.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-geckodriver.svg?style=flat-square)][travis]

[supermarket]: https://supermarket.chef.io/cookbooks/geckodriver
[travis]: https://travis-ci.org/dhoer/chef-geckodriver

Installs geckodriver (https://github.com/mozilla/geckodriver). 

## Requirements

- Chef 12.6+
- Mozilla Firefox (this cookbook does not install Mozilla Firefox)

### Platforms

- CentOS, RedHat
- Mac OS X
- Ubuntu
- Windows

## Usage

Include recipe in a run list or cookbook to install geckodriver.

### Attributes

- `node['geckodriver']['version']` - Version to download. 
- `node['geckodriver']['url']` -  URL download prefix. 
- `node['geckodriver']['windows']['home']` - Home directory for windows. 
- `node['geckodriver']['unix']['home']` - Home directory for both linux and macosx. 

#### Install selenium node with firefox capability

```ruby
include_recipe 'mozilla_firefox'
include_recipe 'geckodriver'

node.override['selenium']['node']['capabilities'] = [
  {
    browserName: 'firefox',
    maxInstances: 1,
    version: firefox_version,
    seleniumProtocol: 'WebDriver'
  }
]

include_recipe 'selenium::node'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/marionette+driver).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-geckodriver/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-geckodriver/graphs/contributors).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-geckodriver/blob/master/LICENSE.md) file for 
details.
