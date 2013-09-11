# Freighthop: Vagrant on Rails


Don't you hate how your dev machine inevitably becomes the superset of all the dependencies of every project you ever worked on? Nobody wants to live in a war zone of data stores fighting for resources.

Vagrant is suppose to help us with this. Package everything in virtual machines, and your life will be amazing! That's the idea at least; but the actual mechanics of getting to that promised land are not all that clear.

----

## !! Alpha Work in Progress !!

**WARNING**: This is a young project; lots of stuff will change as the project evolves.

----

## What is Freighthop?

Freighthop is based around this simple goal:

> When I download a rails project, I want to run a single command that spins me up a VM serving that project.

## Try it out

### Get the prerequisites

* Vagrant 1.3.1
* VMWare Fusion (for now; will support VirtualBox soon)
* Vagrant Plugins (install with `vagrant plugin install $pluginname`):
  * landrush (for DNS)
    * note you'll need to run `vagrant landrush install` to finish this installation procedure
  * vagrant-cachier (for apt caching; will eventually be optional)
  * vagrant-vmware-fusion (for now)


### Clone the project

```
git clone https://github.com/phinze/freighthop
```

### Get the executable on your $PATH

This is a hacky symlink for now; eventually we'll wrap the project up in a distributable package that will do this for you.

```
cd freighthop
ln -s bin/fh /usr/local/bin/fh
```

### Create config

A Freighthop-enabled project just needs to include a `.freighthop.json` something like this:

```json
{
  "freighthop::ruby_version": "2.0.0-p247",
  "freighthop::databases": [
    "myproject_development",
    "myproject_test"
  ],
  "freighthop::database_users": [
    "myproject"
  ],
  "freighthop::packages": [
    "git-core",
    "libpq-dev",
    "libsqlite3-dev",
    "libxml2-dev",
    "libxslt1-dev",
    "nodejs"
  ]
}
```

### Spin it up

```
# boot the VM
fh up
# run your migrations
fh rake db:migrate
```

### Win

Thanks to landrush, we can hit our VM at a friendly URL.

```
curl http://myproject.vagrant.dev
```

### Shut 'er down

```
fh down
```

And your host system is none the wiser! No databases lying around, no daemons hanging out forever in the background; squeaky clean!

## So much to do...

Phew this little project could really use your help!

 * Try to get it running and report any problems you hit.
 * Check out existing issues for the list of things we're working on.
 * Submit your ideas for features as an issue.
 * Do that open source thing where you fork, feature branch, and pull request.
