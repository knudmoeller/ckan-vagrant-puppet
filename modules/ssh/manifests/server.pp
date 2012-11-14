class ssh::server {

  $ssh_service_name = $operatingsystem ? {
    /(?i)(ubuntu|debian)/ => "ssh",
    default => 'sshd'
  }

  service { "$ssh_service_name":
    ensure => running,
  }

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('ssh/server/sshd_config.erb'),
    notify  => Service["$ssh_service_name"]
  }
}
