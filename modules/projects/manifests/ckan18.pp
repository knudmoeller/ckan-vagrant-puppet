# puppet manifest to install CKAN1.8, depends on boxes::ckan for some basic packages
# 
# this manifest is based on the CKAN Install from Source instructions at
# https://github.com/okfn/ckan/blob/release-v1.8/doc/install-from-source.rst

class projects::ckan18 {

	require postgresql

	$project_basedir = "$::hosting_root"

	$db_name = 'ckantest'
	$db_user = 'ckanuser'
	$db_pass = 'pass'

	$virtualenv_name = 'pyenv'
	$virtualenv_root = "$project_basedir/$virtualenv_name"
	$ckan_release = 'release-v1.8'
	
	$site_id = 'daten.berlin.de'
	$jetty_port = '8983'

	# start postgresql server and set up CKAN DB:
	class { 'postgresql::server': }
	-> postgresql::db { $db_name:
		owner     => $db_user,
		password => $db_pass,
	}

	# set up virtualenv
	python::venv::isolate { "$virtualenv_root": }
	-> python::pip::install { "installing CKAN@$ckan_release":
		package => "-e 'git+https://github.com/okfn/ckan.git@$ckan_release#egg=ckan'", 
		venv => "$virtualenv_root",
	}
	-> python::pip::requirements { "$virtualenv_root/src/ckan/pip-requirements.txt":
		venv => "$virtualenv_root",
	}
	-> file { "$virtualenv_root/src/ckan/development.ini":
		content => template("projects/ckan/development.ini.erb"),
		ensure => present,
	}
	-> file { "/etc/default/jetty":
		content => template("projects/ckan/jetty.erb"),
		ensure => present,
	}
	-> exec { "backup SOLR schema":
		command => "mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak",
		onlyif => "test -f /etc/solr/conf/schema.xml", # only if schema.xml is a regular file (and not a symlink)
		# why doesn't this test work?
	}
	-> exec { "symlink new SOLR schema":
		command => "sudo ln -s $virtualenv_root/src/ckan/ckan/config/solr/schema-1.4.xml /etc/solr/conf/schema.xml",
		creates => "/etc/solr/conf/schema.xml",
	}
	-> service { "start jetty on $jetty_port":
    	name        => 'jetty',
    	enable      => true,
    	ensure      => running,
	}
	-> file { "$virtualenv_root/src/ckan/data":
		ensure => directory,
	}
	-> file { "$virtualenv_root/src/ckan/sstore":
		ensure => directory,
	}
	-> exec { "create database tables":
		command => "$virtualenv_root/bin/paster --plugin=ckan db init",
		cwd => "$virtualenv_root/src/ckan", 
	}
	# -> exec { "starting CKAN":
	# 	command => "$virtualenv_root/bin/paster serve development.ini&",
	# 	cwd => "$virtualenv_root/src/ckan",
	# 	user => "vagrant",
	# }
	# the following lead to a dependency cycle, not sure why:
	# -> file { "$virtualenv_root":
	# 	group => "vagrant",
	# 	owner => "vagrant",
	# 	recurse => "true",
	# }
	-> exec { "changing file permissions":
		command => "chown -R vagrant:vagrant $virtualenv_root",
	}


}
