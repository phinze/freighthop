class Freighthop::CLI::Checks
  def self.ensure_config_exists!
    unless Freighthop::Config.exist?
      puts <<-NO_CONFIG
ERROR: No freighthop config file (.freighthop.json) found in current path.
       You can generate a template config with `fh init`, or see `fh help`
       for more information.
      NO_CONFIG
      exit 1
    end
  end
end
