
class sysconfig::users {
    
  # ensure required users are present
  user { "vagrant":
    ensure => present,
    home => "/home/vagrant"
  } -> file { "/home/vagrant":
    ensure => directory,
    owner => vagrant
  }
  user { "root":
    ensure => present,
    home => "/root"
  } -> file { "/root":
    ensure => directory,
    owner => root
  }
  group { "puppet":
    ensure => present
  }

}