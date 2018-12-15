module RequestSpecsHelper

  def data
    JSON.parse(response.body)["data"]
  end

  def meta
    JSON.parse(response.body)["meta"].try(:with_indifferent_access)
  end

  def errors
    JSON.parse(response.body)["data"]["errors"]
  end

  def error_messages
    JSON.parse(response.body)["data"]["errorMessages"]
  end

  def message
    JSON.parse(response.body)["message"]
  end
end
