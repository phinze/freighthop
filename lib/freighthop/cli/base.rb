class Freighthop::CLI::Base
  attr_reader :freighthop

  def self.match?(args)
    raise "abstract superclass"
  end

  def initialize(freighthop)
    @freighthop = freighthop
  end

  def run(args)
    raise "abstract superclass"
  end
end
