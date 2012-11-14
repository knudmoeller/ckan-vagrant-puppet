class git {

  class client {
    package { 'git':
      ensure => installed,
    }
  }

  define clone( 
    $source,
    $localtree = "/srv/git/",
    $user = "vagrant"
  ) {
    exec { 'git-clone-appbase':
      command => "git clone $source $localtree",
      unless => "ls $localtree/.git",
      require => Package['git'],
      user => $user,
      timeout => 3600,
      creates => "$localtree/.git/",
      logoutput => true,
    }
  }

}
