module Api::Mixins::ErrorsMethod
  def errors
    object.errors.try(:messages)
  end

  def error_messages
    object.errors.try(:full_messages)
  end

  def self.included(base)
    base.attributes :errors, :error_messages
  end

  def attributes(*args)
    object.errors.try(:present?) ? super : super.except(*[:errors, :error_messages])
  end
end
