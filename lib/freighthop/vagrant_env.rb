class Freighthop::VagrantEnv
  attr_reader :freighthop

  def initialize(freighthop)
    @freighthop = freighthop
  end

  def env
    {
      'VAGRANT_DOTFILE_PATH' => vagrant_dotfile_path,
      'VAGRANT_CWD'          => vagrant_cwd
    }
  end

  def activate!
    env.each do |key, val|
      ENV[key] = val.to_s
    end
  end

  def vagrant_cwd
    freighthop.freighthop_root
  end

  def vagrant_dotfile_path
    Pathname('~/.freighthop.d/vagrant').expand_path.tap do |path|
      path.mkpath unless path.directory?
    end
  end
end
