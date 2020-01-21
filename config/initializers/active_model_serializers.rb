ActiveModel::Serializer.config.adapter = :json

# ActiveModel::Serializer.root = false

Mime::Type.register 'application/json', :json, %w[text/x-json application/jsonrequest application/vnd.api+json]
