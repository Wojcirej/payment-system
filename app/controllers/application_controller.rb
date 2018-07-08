class ApplicationController < ActionController::API
  include Api::PreDataSerializer
  include Api::JsonRequestParams
  include Api::CommonExceptionHandlers
end
