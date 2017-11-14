Redis.current = Redis.new(:host => ( ENV["REDIS_HOST"] ),
                          :port => ( ENV["REDIS_PORT"] ).to_i,
                          :password => (ENV["REDIS_PASSWORD"] ))
