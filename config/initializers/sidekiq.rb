Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch("REDIS_SERVER","localhost") }
  end
   
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch("REDIS_SERVER","localhost") }
  end