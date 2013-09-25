class Freighthop::Config
  def self.file
    Freighthop.host_root.join('.freighthop.json')
  end

  def self.config
    @config = JSON.parse(file.read)
  end

  def self.fetch(key)
    config[key]
  end
end
