class Port
  require './redis_init'
  #belongs_to :host
  attr_accessor :number
  def initialize(args)
    @number = args[:number]
    @host = args[:host]
  end

  def allocate_port
    $redis.srem(@host.ip, @number)
  end
end