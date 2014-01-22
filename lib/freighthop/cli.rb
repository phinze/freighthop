class Freighthop::CLI; end

require_relative 'cli/checks'
require_relative 'cli/help'
require_relative 'cli/init'
require_relative 'cli/ssh'
require_relative 'cli/vagrant'
require_relative 'cli/version'

class Freighthop::CLI
  COMMANDS = [
    Freighthop::CLI::Version,
    Freighthop::CLI::Help,
    Freighthop::CLI::Init,
    Freighthop::CLI::Vagrant,
    Freighthop::CLI::SSH
  ]

  def initialize(*args)
    @args = args
  end

  def run
    Freighthop::VagrantEnv.activate!

    command = COMMANDS.detect { |c| c.match?(*@args) }
    # no need for a nil check, because CLI::SSH will always match
    command.new(*@args).run
  end
end
