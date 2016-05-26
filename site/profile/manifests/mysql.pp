class profile::mysql{

 class { '::mysql::server':
     root_password => 'password',
  }
 # class { 
 # mysql 
 # } 
} 
