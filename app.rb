class App
  require './redis_init'
  # belongs_to :host
  # belongs_to :port

  def initialize(args)
    @name = args[:name]
    @host = args[:host]
    @port = args[:port]
    $redis.sadd(@name, "#{@host.ip}_#{@port.number}")
  end

end