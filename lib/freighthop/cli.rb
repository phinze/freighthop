class Freighthop::CLI; end

require_relative 'cli/help'
require_relative 'cli/ssh'
require_relative 'cli/vagrant'

class Freighthop::CLI
  COMMANDS = [
    Freighthop::CLI::Help,
    Freighthop::CLI::Vagrant,
    Freighthop::CLI::SSH,
  ]

  def initialize(*args)
    @args = args
  end

  def run
    sanity_check
    Freighthop::VagrantEnv.activate!

    command = COMMANDS.detect(lambda{self.help}) { |c| c.match?(*@args) }
    command.new(*@args).run
  end

  def help
    Freighthop::CLI::Help
  end

  def sanity_check
    return if help.match?(*@args)
    unless Freighthop::Config.exist?
      puts <<-NO_CONFIG
ERROR: No freighthop config file (.freighthop.json) found in current path.
       You probably want to check out the README and/or `fh help`.
      NO_CONFIG
      exit 1
    end
  end
end
