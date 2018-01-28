module ScanHost
  require 'nmap/program'
  require 'nmap/xml'
  require 'yaml'
  CONSTANTS = YAML.load_file('./constants.yml')

  def scan_ports_host(ip)
    Nmap::Program.scan do |nmap|
      nmap.syn_scan = true
      nmap.service_scan = true
      nmap.xml = CONSTANTS['path']
      nmap.verbose = true
      nmap.ports = CONSTANTS['ports']
      nmap.targets = ip
    end
    feed_xml_redis
  end

  def feed_xml_redis
    Nmap::XML.new(CONSTANTS['path']) do |xml|
      xml.each_host do |host|
        puts "[#{host.ip}]"

        host.each_port do |port|
          puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
          $redis.sadd("HOST_PORTS_AVAILABLE", host.ip)
          $redis.sadd(host.ip, port.number)
        end
      end
    end
  end
end