# ---------------------------------
# daten.berlin.de CKAN manifest.php
# ---------------------------------
# 
# OKFN suggest to install on Ubuntu, so I'm not making any checks below for
# the OS - I just assume we use Ubuntu.
#
# After successfully executing this manifest this box in vagrant, 
# CKAN should be running on 33.33.33.10:5000
# (needs to be started manually from within virtual box)


# make sure that commands are always search in the following locations
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# set projects base directory, which is also exported to nfs.
$hosting_root = "/home/vagrant"

# set our default package provider
Package { 
  provider => "apt"
}

class { 'apt':
	purge_sources_list => true
}

# using a generic box for CKAN (installing packages)
# and a more specific project for CKAN1.8
class { 'boxes::ckan': }
-> class { 'projects::ckan18': }
