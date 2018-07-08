module RequestSpecsHelper

  def data
    JSON.parse(response.body)["data"]
  end

  def errors
    JSON.parse(response.body)["errors"]
  end
end
