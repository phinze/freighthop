class Freighthop::Config
  def self.exist?
    file.exist?
  end

  def self.file
    Freighthop.host_root.join('.freighthop.json')
  end

  def self.config
    @config = JSON.parse(file.read)
  end

  def self.fetch(*args)
    config.fetch(*args)
  end
end
