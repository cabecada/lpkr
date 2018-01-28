Deploy given N apps in available M machines which has free ports

redis is used as data store
redis_keys:
	IPS_LIST -- list of machines
	HOST_PORTS_AVAILABLE -- list of machines which has free ports
	IP -- list of ports free in the host

scanner.rake -- scans available ports in given ips and adds in redis

port_scanner.rb -- deploys the given app in any available machine
i/p: ruby port_scanner.rb no_of_apps
then no_of_apps lines app names