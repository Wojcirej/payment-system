class ApplicationController < ActionController::API
  include Api::PreDataSerializer
  include Api::CommonExceptionHandlers
end
