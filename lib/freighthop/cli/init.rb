class Freighthop::CLI::Init
  def self.match?(*args)
    args.first == 'init'
  end

  attr_reader :language

  def initialize(*args)
  end

  def run
    if Freighthop::Config.exist?
      puts "This directory already contains a #{Freighthop::Config.file.basename}"
      exit 1
    end

    puts "Writing a new config to #{Freighthop::Config.file.basename}"
    Freighthop::Config.write(default_config)
  end

  def default_config
    {
      'freighthop::cpus'                         => 2,
      'freighthop::ram'                          => 512,
      'freighthop::languages'                    => ['ruby'],
      'freighthop::web_port'                     => 3000,
      'freighthop::database::flavors'            => ['postgres'],
      'freighthop::database::postgres::db_names' => [],
      'freighthop::database::postgres::users'    => [],
      'freighthop::ppas'                         => [],
      'freighthop::packages'                     => [],
    }
  end
end
