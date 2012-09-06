# basic site manifest

# define global paths and file ownership
Exec { path => '/usr/sbin/:/sbin:/usr/bin:/bin' }
File { owner => 'root', group => 'root' }

# create a stage to make sure apt-get update is run before all other tasks
stage { 'bootstrap': before => Stage['requirements'] }
stage { 'requirements': before => Stage['main'] }

class jmeter::bootstrap {
  # we need an updated list of sources before we can apply the configuration
	exec { 'jmeter_apt_update':
		command => '/usr/bin/apt-get update',
	}
}

class jmeter::requirements {
  package { ['htop', 'unzip']:
    ensure => present,
  }
}

class jmeter::install {
  class { 'jmeter::server': }

  exec { 'download-jmeter-plugins':
    command => 'wget -P /root http://jmeter-plugins.googlecode.com/files/JMeterPlugins-0.5.4.zip',
    creates => '/root/JMeterPlugins-0.5.4.zip'
  }

  exec { 'install-jmeter-plugins':
    command => 'unzip -q -d JMeterPlugins JMeterPlugins-0.5.4.zip  && mv JMeterPlugins/JMeterPlugins.jar /usr/share/jmeter/lib/ext',
    cwd     => '/root',
    creates => '/usr/share/jmeter/lib/ext/JMeterPlugins.jar',
    require => [Exec['install-jmeter'], Exec['download-jmeter-plugins']],
    notify  => Service['jmeter'],
  }
}

class jmeter::go {
  class { 'jmeter::bootstrap':
    stage => 'bootstrap',
  }
  class { 'jmeter::requirements':
    stage => 'requirements',
  }
  class { 'jmeter::install': }
}

include jmeter::go