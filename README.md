# Freighthop: Vagrant on Rails


Don't you hate how your dev machine inevitably becomes the superset of all the dependencies of every project you ever worked on? Nobody wants to live in a war zone of data stores fighting for resources.

Vagrant is suppose to help us with this. Package everything in virtual machines, and your life will be amazing! That's the idea at least; but the actual mechanics of getting to that promised land are not all that clear.

## What is Freighthop?

Freighthop is based around this simple goal:

> When I download a rails project, I want to run a single command that spins me up a VM serving that project.

With a few commands from the project root of any Rack-compatible app, Freighthop can spin up a VM that serves that project at `projectname.vagrant.dev`. Freighthop takes care of the bundle install, the server configuration, and the database, and it provides a helper executable that allows you to interact with the VM.

----

## !! Alpha Work in Progress !!

**WARNING**: This is a young project; lots of stuff will change as the project evolves.

----


## Try it out

This is a little involved at the moment (cuz alpha). Should simplify as the project evolves.

### Get the prerequisites

* Vagrant 1.3.1
* Vagrant Plugins (install with `vagrant plugin install $pluginname`):
  * landrush (for DNS; note you'll need to run `vagrant landrush install` to finish this installation procedure)
  * vagrant-cachier (for apt caching; will eventually be optional)


### Install the gem

```
gem install freighthop
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

## `fh` - the friendly executable helper

For now this is a tiny bash script that mostly just delegates down to `vagrant`. Here are the important commands from vagrant:

 * `fh up` - start and provision the VM
 * `fh provision` - kick off provisioning if you change your config or something breaks
 * `fh ssh` - log into your VM
 * `fh halt` - shut down the VM
 * `fh destroy` - delete the VM

And it also knows a few special commands of its own:

 * `fh run '$COMMAND'` - run a command from the CWD of your project on the VM
 * `fh console` - attempts to run a rails console inside the VM
 * `fh rake $TASK` - runs a rake task in your project on the VM

## So much to do...

We're just getting started; this little project could really use your help!

 * Try to get it running and report any problems you hit.
 * Check out existing issues for the list of things we're working on.
 * Submit your ideas for features as an issue.
 * Do that open source thing where you fork, feature branch, and pull request.
