# Puppet Recipes

The recipes here are tested on suse12.1 and ubuntu11.10

## boxes

This is where puppet meets vagrant.
We define boxes that bootstrap dev environments for projects on a specific plattform.
These boxes combine a devbox from the boxes module with a concrete project and host it inside vagrant.
You define the desired plattform inside the Vagrantfile and combine a devbox with a project to setup your desired environment.

## modules/boxes

Basic devbox layouts you can choose from.

## modules/projects

Project definitions.

## Setup

1. Install virtual box and the virtual box extension pack: https://www.virtualbox.org/
2. Install vagrant: http://vagrantup.com/
3. Install the vagrant-vbguest plugin: `vagrant gem install vagrant-vbguest`
3. Clone this repository: `git clone git@github.com:berlinonline/puppets.git`
4. Navigate into the directory of the desired box and run: `vagrant up`
5. Get a coffee and by the time you're back, you are setup for development.
So pull out your ide/editor and to get started: 
mount nfs://33.33.33.10/home/vagrant/projects
