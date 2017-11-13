Redis.current = Redis.new(:host => ( ENV["REDIS_HOST"] || '127.0.0.1'),
                          :port => ( ENV["REDIS_PORT"] || '6379').to_i,
                          :password => (ENV["REDIS_PASSWORD"] || ''))
