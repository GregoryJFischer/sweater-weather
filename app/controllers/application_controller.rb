class ApplicationController < ActionController::API
  include ExceptionHandler
  # def request_info
  #   JSON.parse(request.body.read, symbolize_names: true)
  # end
end
