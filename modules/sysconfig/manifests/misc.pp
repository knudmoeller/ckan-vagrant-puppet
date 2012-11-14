
class sysconfig::misc {
    
  package { 'curl':
    ensure => installed
  }

  package { 'vim':
    ensure => installed
  }

}
