### What is it?

A Vagrant configuration that starts up a PostgreSQL database in a virtual machine for local application development.

### Installation

First install [Vagrant] and [Virtual Box].

Then, run the following to create a new PostgreSQL app dev virtual machine:

	# Clone it locally:
    $ git clone https://github.com/jackdb/pg-app-dev-vm myapp

    # Enter the cloned directory:
    $ cd myapp

    # Delete the old .git and README:
    $ rm -rf README.md .git

    # Optionally edit the database username/password:
    $ $EDITOR Vagrant-setup/bootstrap.sh

### Usage

    # Start up the virtual machine:
    $ vagrant up

    # Stop the virtual machine:
    $ vagrant halt

### What does it do?

It creates a virtual server running Ubuntu 14.04 with the latest version of PostgreSQL (*as of writing 9.4*) installed. It also edits the PostgreSQL configuration files to allow network access and creates a database user/database for your application to use.

Once it has started up it will print out how to access the database on the virtual machine. It will look something like this:

    $ vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    [... truncated ...]
    Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: 15432)
      Host: localhost
      Port: 15432
      Database: myapp
      Username: myapp
      Password: dbpass

    Admin access to postgres user via VM:
      vagrant ssh
      sudo su - postgres

    psql access to app database user via VM:
      vagrant ssh
      sudo su - postgres
      PGUSER=myapp PGPASSWORD=dbpass psql -h localhost myapp

    Env variable for application development:
      DATABASE_URL=postgresql://myapp:dbpass@localhost:15432/myapp

    Local command to access the database via psql:
      PGUSER=myapp PGPASSWORD=dbpass psql -h localhost -p 15432 myapp

### Why use the shell provisioner?

Or alternatively, why not [Chef](http://www.getchef.com/chef/), [Puppet](http://puppetlabs.com/), [Ansible](http://www.ansibleworks.com/), or [Salt](http://www.saltstack.com/)?

Mainly because it's simple and anybody with a basic knowledge of shell scripting can tweak the `bootstrap.sh` to their liking.

### License

This is released under the MIT license. See the file [LICENSE](LICENSE).

[Virtual Box]: https://www.virtualbox.org/
Vagrant]: http://www.vagrantup.com/
