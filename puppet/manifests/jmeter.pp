# basic site manifest

# define global paths and file ownership
Exec { path => '/usr/sbin/:/sbin:/usr/bin:/bin' }
File { owner => 'root', group => 'root' }

# create a stage to make sure apt-get update is run before all other tasks
stage { 'bootstrap': before => Stage['main'] }

class jmeter::bootstrap {
  # we need an updated list of sources before we can apply the configuration
	exec { 'jmeter_apt_update':
		command => '/usr/bin/apt-get update',
	}
}

class jmeter::install {
  class { 'jmeter::server': }
}

class jmeter::go {
  class { 'jmeter::bootstrap':
    stage => 'bootstrap',
  }
  class { 'jmeter::install': }
}

include jmeter::go