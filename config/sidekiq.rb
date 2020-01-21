Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL_SIDEKIQ"]}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL_SIDEKIQ"]}
end

require "sidekiq/web"
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV["SIDEKIQ_WEB_USERNAME"], ENV["SIDEKIQ_WEB_PASSWORD"]]
end
