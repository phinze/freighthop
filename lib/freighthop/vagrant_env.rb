class Freighthop::VagrantEnv
  def self.env
    {
      'VAGRANT_DOTFILE_PATH' => vagrant_dotfile_path,
      'VAGRANT_CWD'          => vagrant_cwd
    }
  end

  def self.activate!
    env.each do |key, val|
      ENV[key] = val.to_s
    end
  end

  def self.vagrant_cwd
    Freighthop.freighthop_root
  end

  def self.vagrant_dotfile_path
    Pathname('~/.freighthop.d/vagrant').expand_path.tap do |path|
      path.mkpath unless path.directory?
    end
  end
end
