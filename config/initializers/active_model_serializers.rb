ActiveModel::Serializer.config.tap do |config|
  config.adapter = :json
  config.key_transform = :camel_lower
end
