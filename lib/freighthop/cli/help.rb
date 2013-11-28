class Freighthop::CLI::Help < Freighthop::CLI::Base
  TOPICS = []

  def self.match?(args)
    args.first == 'help' || args.empty?
  end

  def run(args)
    _, topic, *_ = args
    if TOPICS.include?(topic)
      # NYI
    else
      usage
    end
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
