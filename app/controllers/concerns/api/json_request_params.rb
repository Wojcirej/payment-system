module Api::JsonRequestParams

  private

  def json
    return @json if @json
    body = request.body.read
    @json = ActiveSupport::JSON.decode(body).with_indifferent_access.deep_transform_keys!(&:underscore)
  end
end
