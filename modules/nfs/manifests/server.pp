# puppet manifests for a nfs server installation
class nfs {
  
  # writes a new /etc/exports file
  # takes an object like: {
  # '/path/exported/directory' => 'export_to_and_nfs_export_options',
  # '/home/jon' => '0.0.0.0/0.0.0.0(rw,insecure,sync)'
  # }
  define export( $exports ) {
    file { "/etc/exports":
      content => template("nfs/server/exports.erb"),
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => '644',
      notify => Service['nfs-server']
    }
  }

  class server ($exports = '') {

    if '' != $exports {
      nfs::export {"/etc/exports":
        exports => $exports
      }
    }

    if $operatingsystem == 'OpenSuSE' {
      # opensuse nfs handling
      package {"yast2-nfs-server":
        ensure => installed,
      }
      service {"rpcbind":
        ensure => running,
        enable => true
      }
      -> service {"nfsserver":
        ensure => running,
        enable => true,
        require => Package["yast2-nfs-server"],
        alias => 'nfs-server'
      }
    } else {
      # others (ubuntu|debian) nfs handling
      service { "nfs-kernel-server":
        ensure => running,
        enable => true,
        require => Package['nfs-kernel-server'],
        alias => 'nfs-server'
      }
      package { 'nfs-kernel-server':
        ensure => installed
      }
    }

  }

}