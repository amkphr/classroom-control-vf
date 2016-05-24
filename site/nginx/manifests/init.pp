class nginx {

      package {'nginx': 
        ensure => present,
      }
      
      file {'/var/www':
        ensure => directoy,
        owner => 'root',
        group => 'root',
        mode => '0775',
      }
}
