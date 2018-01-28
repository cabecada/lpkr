require './redis_init'

include 'RedisKeys'
include ScanHost

desc "Scan Hosts for free ports"

task :scan_nmap do 
	#get list of ips

	ips = $redis.smembers("IPS_LIST")
	ips.each do |ip|
		scan_host(ip)
  end
end