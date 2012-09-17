Vagrant::Config.run do |config|
  config.vm.host_name = 'jmeter.vagrantup.com'

  # the base box this environment is built off of
  config.vm.box = 'precise32'

  # the url from where to fetch the base box if it doesn't exist
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'

  # attach network adapters
  ip = '33.33.33.40'
  config.vm.network :hostonly, ip, {:adapter => 2}

  # jmeter needs heaps of memory
  config.vm.customize ['modifyvm', :id, '--memory', 1024, '--name', 'Vagrant JMeter']

  # use puppet to provision packages
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'jmeter.pp'
    puppet.module_path = 'puppet/modules'
    puppet.facter = {'jmeterip' => ip}
  end
end