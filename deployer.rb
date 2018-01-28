class Deployer
  require './redis_init'
  require './host'
  require './port'
  require './app'

  def get_random_free_machine
    available_hosts= $redis.smembers("HOST_PORTS_AVAILABLE")
    available_hosts.size > 0 ? available_hosts.sample : "0"
  end

  def deploy_app(ip, apps)
    host = Host.new({:ip=> ip})
    free_port = host.random_free_port
    if free_port
      port = Port.new({:number=> free_port, :host => host})
      app = App.new({:host=> host, :port=> port, :name=> apps[deployed_app_count]})
      puts "Deployed app: #{apps[deployed_app_count]} in machine: #{ip}, port: #{free_port}"
      incr_deployed_app
      port.allocate_port
    end
  end

  def deployed_app_count
    $redis.get("counter").to_i
  end

  def incr_deployed_app
    $redis.incr("counter")
  end
end