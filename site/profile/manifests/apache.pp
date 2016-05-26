class profile::apache{
 include ::apache
 include ::apache::mod::php
 $wp_home = '/opt/wordpress'
 $blog_name = 'blog city' 
 
 host { "$blog_name}.puppetlabs.com"
 } 
 # class { 
 # mysql 
 # } 
} 
