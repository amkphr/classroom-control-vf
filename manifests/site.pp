File { backup => false }

ini_setting { 'random ordering':
   ensure  => present,
   path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
   setting => 'ordering',
   value   => 'title-hash',
 }

 
node default {
   # This is where you can declare classes for all nodes.
   # Example:
  #   class { 'my_class': }
   notify { "Hello, my name is ${::hostname}": }
   
   host { 'testing host entry':
   name => 'testing.puppetlabs.vm', 
   ip => '127.0.0.1', 
   } 
  
   exec {"cowsay 'Welcome to ${::fqdn}!' > /etc/motd" :
     path => '/usr/bin:/usr/local/bin',
    creates => '/etc/motd', 
   }
   
   }

