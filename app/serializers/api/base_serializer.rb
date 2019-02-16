class Api::BaseSerializer < ActiveModel::Serializer
  include Api::Mixins::ErrorsMethod
end
