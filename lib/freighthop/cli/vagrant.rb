class Freighthop::CLI::Vagrant < Freighthop::CLI::Base
  COMMANDS = %w[
    up
    halt
    destroy
    provision
    reload
    status
  ]

  def self.match?(args)
    COMMANDS.include?(args.first)
  end

  def run(args)
    subcommand, rest = args
    rest = Array(rest).join(' ')

    exec %Q(vagrant #{subcommand} #{rest})
  end
end
