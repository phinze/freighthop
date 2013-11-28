class Freighthop::Config

  attr_reader :freighthop
  def initialize(freighthop)
    @freighthop = freighthop
  end

  def exist?
    file.exist?
  end

  def file
    freighthop.host_root.join('.freighthop.json')
  end

  def config
    @config = JSON.parse(file.read)
  end

  def fetch(*args)
    config.fetch(*args)
  end
end
