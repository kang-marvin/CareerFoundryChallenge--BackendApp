Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Select test framework.
    with.test_framework :rspec

    with.library :rails
  end
end
