class PortScanner
  require './redis_init'
  require './deployer'

  no_of_apps = ARGV[0]
  apps = []
  puts "Input #{no_of_apps} number of apps"
  $redis.set("counter", 0)   # count for no.of.apps deployed
  undeployed_apps_index = 0
  for i in 1..no_of_apps.to_i 
    apps << STDIN.gets.chomp
  end

  deploy = Deployer.new

  ips = $redis.smembers("HOST_PORTS_AVAILABLE")
  puts "hosts free: #{ips}"
  ips.each do |ip| #deploy apps selecting machines in round robin
    deploy.deploy_app(ip,apps)
  end

  counter = deploy.deployed_app_count

  p "Undeployed app counter: #{counter}"

  if counter < apps.size # deploy remaining apps after round robin, we can change this to select machine based on least load
    for i in counter..apps.size - 1 
      ip = deploy.get_random_free_machine     
      if ip!="0"
        deploy.deploy_app(ip, apps)
      else
        puts "No free machines"
        undeployed_apps_index = i
        break;
      end
    end
  end
  puts "undeployed apps: #{apps[undeployed_apps_index..-1]}" if undeployed_apps_index > 0
# rescue Exception => e
#   puts "Exception: #{e}"
end