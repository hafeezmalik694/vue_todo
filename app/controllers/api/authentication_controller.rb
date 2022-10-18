class Api::AuthenticationController < Api::BaseController
  skip_before_action :authenticate_request
  include Response
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      json_success_response('User Successfully logged in.', command.result[:user])
    else
      json_error_response('Something Went Wrong.', command.errors)
    end
  end
end