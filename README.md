Vagrant JMeter
==============

A basic JMeter server setup configured for use when simulating remote execution of test plans.


Installation
------------

1. Download and install Vagrant: http://vagrantup.com/
2. Clone this repository using the `--recursive` flag (to get the submodules).
3. Go to the root of the repository and run `vagrant up`. Building the virtual machine usually only takes around five minutes.


Getting started
---------------

When the virtual machine has booted, you can access the JMeter instance on the following IP address:

    33.33.33.40

To use the new JMeter server, you must tell the JMeter client that it exists. You can either modify the `remote_hosts` setting in the `jmeter.properties` file or pass the `-R` parameter when running JMeter.

If you want to control your JMeter servers from the GUI, you must edit the `jmeter.properties` file.

If you are running JMeter headless, you can simply pass a list of JMeter servers using the `-R` parameter:

    jmeter -R33.33.33.40[,33.33.33.41,...]


Author
------

Morten Wulff  
<wulff@ratatosk.net>