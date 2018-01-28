require './redis_init'
require './scan_host'

include ScanHost

#get list of ips
ips = $redis.smembers("IPS_LIST")
ips.each do |ip|
	scan_ports_host(ip)
end
