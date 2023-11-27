redis_url = ENV.fetch("REDIS_SERVER","localhost")

REDIS = Redis.new(url: redis_url)