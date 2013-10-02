class Freighthop::CLI
  def initialize(*args)
    @args = args
  end

  def run!
    Freighthop::VagrantEnv.activate!

    subcommand, *rest = @args
    case subcommand
    when 'help' then
      usage
    when 'up', 'halt', 'destroy', 'provision', 'reload', 'status' then
      exec %Q(vagrant #{subcommand} #{rest.join(' ')})
    when 'ssh' then
      ssh('-i')
    else
      ssh(%Q(-c "#{@args.join(' ')}"))
    end
  end

  def ssh(cmd)
    exec %Q(ssh -t -F #{ssh_config} #{app_name} 'cd #{guest_root}; sudo /bin/bash -l #{cmd}')
  end

  def ssh_config
    Pathname("/tmp/freighthop.#{app_name}.ssh-config").tap do |conf|
      if !conf.exist? || (Time.now - conf.mtime) > 86400
        `vagrant ssh-config > #{conf}`
      end
    end
  end

  def app_name
    Freighthop.app_name
  end

  def guest_root
    Freighthop.guest_root
  end

  def usage
    puts <<USAGETEXT
NAME
  fh - freighthop's friendly helper

DESCRIPTION
  The fh command is used to interact with a freighthop-managed vm from the root
  of your project directory.

SYNOPSIS
  fh <COMMAND> [args...]

BUILT-IN COMMANDS
  up        - boot freighthop vm
  halt      - shutdown freighthop vm
  destroy   - shutdown and delete vm
  provision - rerun provisioning on a booted freighthop vm
  reload    - restart freighthop vm (picks up new config changes)
  status    - check the current status of the freighthop vm
  ssh       - opens a root shell inside the project dir of the freighthop vm
  (other)   - see PASSTHROUGH TO VM below
  help      - this help

PASSTHROUGH TO VM
  Anything that does not match the above list will be passed through to the
  freighthop vm.

  The command will be run in a bash shell, as root, from inside the shared
  project directory.

  This allows you to specify relative commands like ./script/server and expect
  them to behave properly.

EXAMPLES
  Install gem dependencies:
    fh bundle install

  Start a Rails 4 server:
    fh ./bin/rails server

  Run a ruby test:
    fh ruby -Itest test/unit/object_test.rb

  Install leiningen dependencies:
    fh lein deps

  Run a ring server:
    fh lein ring server-headless
USAGETEXT
  end
end
