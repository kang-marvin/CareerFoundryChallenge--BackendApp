# frozen_string_literal: true

# there is a mailer initializer file that has mailer configurations
# for both testing and production env(config/initializers/mailer.rb),
# I can't make any changes to this file right now because
# I have no idea how it could affect live production
# and staging environments.

# I will override this configuration for testing purpose.

# NB: This configuration will only be applied when running tests

Rails.application.configure do
  config.action_mailer.delivery_method = :test
end
