REQUEST_TIMEOUT = {
  'development' => 50,
  'test'        => ENV['MAX_REQUEST_TIMEOUT'].to_i,
  'production'  => ENV['MAX_REQUEST_TIMEOUT'].to_i
}
REQUEST_TIMEOUT.default = 40

unless Rails.env.development?
  Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: REQUEST_TIMEOUT[Rails.env]
end
