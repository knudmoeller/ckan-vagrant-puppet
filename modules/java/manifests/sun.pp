
class java::sun {
  if $operatingsystem == 'OpenSuSE' {
    # @todo: also switch to openjdk-7-jre here pls
    exec { 'add-java-sun-repo':
      command => 'zypper ar http://download.opensuse.org/repositories/Java:/sun:/Factory/openSUSE_12.1/Java:sun:Factory.repo',
      unless => 'zypper lr | grep Java_sun_Factory',
      returns => [0, 1]
    }
    exec { 'refresh-java-repos':
      command => 'zypper --no-gpg-checks refresh',
      returns => [0, 1],
      require => Exec['add-java-sun-repo']
    }

    package { 'java-1_7_0-sun':
      ensure => installed,
      require => Exec['refresh-java-repos']
    }
  } else {
    package { 'openjdk-7-jre':
      ensure => installed
    }
  }
}
