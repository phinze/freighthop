class Freighthop::CLI::Vagrant
  COMMANDS = %w[
    up
    halt
    destroy
    provision
    reload
    status
  ]

  def self.match?(*args)
    COMMANDS.include?(args.first)
  end

  def initialize(*args)
    @subcommand, @rest = args
  end

  def args
    ([*@rest] || []).join(' ')
  end

  def run
    Freighthop::CLI::Checks.ensure_config_exists!
    exec %Q(vagrant #{@subcommand} #{args})
  end
end
