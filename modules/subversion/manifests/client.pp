
class subversion {
  
  class client {
    package { 'subversion':
      ensure => installed,
    }
  }

  define checkout (
    $source, 
    $localtree, 
    $username, 
    $password, 
    $exec_user = "vagrant"
  ) {
    exec { "subversion-checkout-$url":
      command => "svn checkout $source $localtree --username='$username' --password='$password'",
      unless => "ls $localtree/.svn",
      require => Package['subversion'],
      user => $exec_user,
      timeout => 3600,
      creates => "$localtree/.svn/",
      logoutput => true,
    }
  }

}