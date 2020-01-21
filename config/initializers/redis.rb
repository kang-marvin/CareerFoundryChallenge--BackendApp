env = {
  'production'  => 'Production_RelishCareers',
  'staging'     => 'Staging_RelishCareers',
  'test'        => 'Test_RelishCareers',
  'development' => 'Development_RelishCareers'
}

redis = Rails.env.development? ? Redis.new : Redis.new(url: ENV['REDISCLOUD_URL'])
$redis = Redis::Namespace.new(env[ENV['RACK_ENV'] || 'developmemt'], redis: redis)

