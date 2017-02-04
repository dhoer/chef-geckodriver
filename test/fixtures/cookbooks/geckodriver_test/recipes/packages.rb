# Installs packages required by selenium-webdriver gem for rspec testing
case node[:platform_family]
when 'debian'
  package 'gcc'
  package 'libffi-dev'
when 'rhel'
  package 'gcc'
  package 'libffi-devel'
end
