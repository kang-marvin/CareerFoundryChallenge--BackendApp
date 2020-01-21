# Inherit from the Aplication Controller which inherits from API:Base rails

# ! READ THIS ON HOW TO SETUP REACT JS
# ! [
# !   https://www.sitepoint.com/react-rails-5-1/
# !   https://medium.com/@nick.hartunian/knock-jwt-auth-for-rails-api-create-react-app-6765192e295a
# !   https://www.youtube.com/watch?v=AiVj2xyTBcw
# ! ]

module Api
  class ApiApplicationController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_rescue
    rescue_from Rack::Timeout::RequestTimeoutException, with: :timeout_gracefully

    def record_invalid_rescue(exception)
      render json: {}, status: 422 if Rails.env.production?
      render json: {
        message: exception,
        backtrace: exception.backtrace.sub("\n\t", ": #{e}#{e.class ? " (#{e.class})" : ''}\n\t")
      }, status: 422
      Rails.logger.info("#{exception.class}: " + exception.message)
    end

    def record_not_found
      render json: {errors: ['Record Not Found']}, status: 404 and return
    end

    def timeout_gracefully
      render json: {}, status: 408 and return
    end

    def each_with_serializer(array_data: [], serializer: DefaultSerializer)
      ActiveModelSerializers::SerializableResource.new(array_data, each_serializer: serializer).as_json
    end

    def with_serializer(data: [], serializer: DefaultSerializer)
      ActiveModelSerializers::SerializableResource.new(data, serializer: serializer).as_json
    end

  end
end