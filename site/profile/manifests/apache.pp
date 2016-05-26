class profile::apache{
 include ::apache
 include ::apache::mod::php
 # class { 
 # mysql 
 # } 
} 
