class nginx {
  Yumrepo {
    ensure => present,
    enabled => '1',
    gpgcheck => '1', 
    priority => '99', 
    skip_if_unavailable => '1', 
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    before     => [ Package['nginx'], Package['openssl-libs'] ],
  }
  
  File {
    owner => 'root',
    group => 'root',
    mode => '0664',
  }
  

  yumrepo { 'base':
    descr               => 'CentOS-$releasever - Base',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra',
  }
  
  yumrepo { 'updates':
    descr               => 'CentOS-$releasever - Updates',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra',
  }
  
  yumrepo { 'extras':
    descr               => 'CentOS-$releasever - Extras',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra',
  }
  
  yumrepo { 'centosplus':
    descr      => 'CentOS-$releasever - Plus',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra',
  }

  package { [ 'openssl', 'openssl-libs' ] :
    ensure => '1.0.1e-51.el7_2.5',
    before => Package['nginx'],
  }

  file { 'nginx rpm' :
    ensure   => file,
    path     => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    source   => 'puppet:///modules/nginx/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
  }

  package { $module_name :
    ensure   => '1.6.2-1.el7.centos.ngx',
    source   => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    provider => rpm,
    require  => File['nginx rpm'],
  }
  
  file { '/var/www/' :
    ensure  => directory,
    require => Package['nginx'],
  }

  file { '/var/www/index.html' :
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
  }

  file { 'nginx conf' :
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service['nginx'],
  }

  file { 'default conf' :
    ensure  => file,
    path    => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
  }

  service { 'nginx' :
    ensure => running,
    enable => true,
    require => [File['index.html']], 
    subscribe => [File['nginx conf'], File['default conf']], 
  }

}
