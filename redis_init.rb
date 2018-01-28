require 'yaml'
require 'redis'
config = YAML::load_file('/Users/user/stud/ot/lpkr/redis.yml')
$redis = Redis.new(:host => config['host'], :port=> config['port'], :timeout=> config['timeout'])