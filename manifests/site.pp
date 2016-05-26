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
   
   if $::virtual != 'physical' {
      $vmname = capitalize($::virtual)
      notify { "This is a ${vmname} virtual machine.": }
   }
   
   include users
   
   include skeleton 
   
   include memcached
   
   include nginx
   
   # Lab 18.1 begin 
   class { 'nginx': 
      root => 'var/vvv/',
   }
   # Lab 18.1 end 
   
   # lab 15.1 begin
   include users::admins
   # lab 15.1 end 
   
   # Lab 17.1 begin
   $message = hiera('message') 
   
   notify { "The value Hiera returns for messgae is = ${message} " : } 
   
   
   
   host { 'testing host entry':
   name => 'testing.puppetlabs.vm', 
   ip => '127.0.0.1', 
   } 
  
   exec {"cowsay 'Welcome to ${::fqdn}!' > /etc/motd" :
     path => '/usr/bin:/usr/local/bin',
    creates => '/etc/motd', 
   }
   
   }

