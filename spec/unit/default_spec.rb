require 'spec_helper'

describe 'geckodriver::default' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: 'C:/chef/cache', platform: 'windows', version: '2008R2') do
        ENV['SYSTEMDRIVE'] = 'C:'
      end.converge(described_recipe)
    end

    it 'creates home directory' do
      expect(chef_run).to create_directory('C:/geckodriver')
    end

    it 'creates work directory' do
      expect(chef_run).to create_directory('C:/geckodriver/geckodriver-v0.14.0-win64')
    end

    it 'downloads geckodriver' do
      expect(chef_run).to create_remote_file(
        'download https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-win64.zip'
      ).with(
        path: "#{Chef::Config[:file_cache_path]}/geckodriver-v0.14.0-win64.zip",
        source: 'https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-win64.zip'
      )
    end

    it 'unzips via powershell' do
      expect(chef_run).to_not run_powershell_script('unzip C:/chef/cache/geckodriver-v0.14.0-win64.zip').with(
        command: 'powershell.exe -nologo -noprofile -command "& { Add-Type -A '\
          "'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory("\
          "'#{Chef::Config[:file_cache_path]}/geckodriver-v0.14.0-win64.zip', "\
          "'C:/geckodriver'); }\""
      )
    end

    it 'links driver' do
      expect(chef_run).to create_link('C:/geckodriver/geckodriver.exe').with(
        to: 'C:/geckodriver/geckodriver-v0.14.0-win64/geckodriver.exe'
      )
    end

    it 'sets PATH' do
      expect(chef_run).to modify_env('geckodriver path').with(
        key_name: 'PATH',
        value: 'C:/geckodriver/geckodriver.exe'
      )
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0'
      ).converge(described_recipe)
    end

    it 'creates home directory' do
      expect(chef_run).to create_directory('/opt/geckodriver')
    end

    it 'creates work directory' do
      expect(chef_run).to create_directory('/opt/geckodriver/geckodriver-v0.14.0-linux64')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file(
        'download https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-linux64.tar.gz'
      ).with(
        path: "#{Chef::Config[:file_cache_path]}/geckodriver-v0.14.0-linux64.tar.gz",
        source: 'https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-linux64.tar.gz'
      )
    end

    it 'untar geckodriver' do
      expect(chef_run).to_not run_execute('untar /var/chef/cache/geckodriver-v0.14.0-linux64.tar.gz')
    end

    it 'links driver' do
      expect(chef_run).to create_link('/usr/bin/geckodriver').with(
        to: '/opt/geckodriver/geckodriver-v0.14.0-linux64/geckodriver'
      )
    end
  end

  context 'mac_os_x' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'mac_os_x', version: '10.10'
      ).converge(described_recipe)
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('/opt/geckodriver/geckodriver-v0.14.0-macos64')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file(
        'download https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-macos64.tar.gz'
      ).with(
        path: "#{Chef::Config[:file_cache_path]}/geckodriver-v0.14.0-macos64.tar.gz",
        source: 'https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-macos64.tar.gz'
      )
    end

    it 'untar geckodriver' do
      expect(chef_run).to_not run_execute('untar /var/chef/cache/geckodriver-v0.14.0-macos64.tar.gz')
    end

    it 'links driver' do
      expect(chef_run).to create_link('/usr/bin/geckodriver').with(
        to: '/opt/geckodriver/geckodriver-v0.14.0-macos64/geckodriver'
      )
    end
  end
end
