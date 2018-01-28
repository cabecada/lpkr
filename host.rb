class Host
  require './redis_init'
  require './scan_host'
  include ScanHost
  # has_many :apps
  # has_many :ports
  attr_accessor :ip

  def initialize(args)
    @ip = args[:ip]
  end

  def deployed_apps
    key = "#{ip}_apps"
    apps = $redis.smembers(key)
  end

  def random_free_port
    ports = free_ports
    ports.sample
  end

  private

  def free_ports
    scan_port(@ip)
    $redis.smembers(@ip)
  end

  def scan_port(ip)
    scan_ports_host(ip)    
  end

end