class Api::BaseController < ApplicationController
  include Response
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  attr_reader :current_user
  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    json_error_response('Something Went Wrong', 'Not Authorized') unless @current_user
  end
end