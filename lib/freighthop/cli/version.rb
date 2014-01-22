require_relative '../version'

class Freighthop::CLI::Version

  def initialize(*args)
    @args = args
  end

  def run
    puts "Freighthop #{Freighthop::VERSION}"
  end

  def self.match?(*args)
    ['version', '-v', '--version' ].include?(args.first)
  end

end
