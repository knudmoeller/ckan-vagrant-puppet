
class sysconfig::repositories {

  if $operatingsystem == 'ubuntu' {
    # add common ubuntu repos
    apt::source {"ubuntu_restricted": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric', repos => 'main restricted', }
    -> apt::source {"ubuntu_universe": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric', repos => 'universe', }
    -> apt::source {"ubuntu_multiverse": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric', repos => 'multiverse', }
    -> apt::source {"ubuntu_update_restricted": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric-updates', repos => 'main restricted', }
    -> apt::source {"ubuntu_update_universe": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric-updates', repos => 'universe', }
    -> apt::source {"ubuntu_update_multiverse": location => 'http://archive.ubuntu.com/ubuntu/', release => 'oneiric-updates', repos => 'multiverse', }
    -> apt::source {"ubuntu_security_restricted": location => 'http://security.ubuntu.com/ubuntu', release => 'oneiric-security', repos => 'main restricted', }
    -> apt::source {"ubuntu_security_universe": location => 'http://security.ubuntu.com/ubuntu', release => 'oneiric-security', repos => 'universe', }
    -> apt::source {"ubuntu_security_multiverse": location => 'http://security.ubuntu.com/ubuntu', release => 'oneiric-security', repos => 'multiverse', }
    -> package { "python-software-properties":
      ensure => installed
    }
  }

}