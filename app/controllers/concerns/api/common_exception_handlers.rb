module Api::CommonExceptionHandlers
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def record_not_found(e)
      render json: { message: e.message }, root: :errors, status: :not_found
    end
  end
end
