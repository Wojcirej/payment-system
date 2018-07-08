module Api
  class BaseSerializer < ActiveModel::Serializer
    include Api::Mixins::ErrorsMethod
  end
end
