module Response

  def json_success_response(message, data = {})
    render json: { success: true, message: message, data: data }
  end

  def json_error_response(message, error = {})
    render json: { success: false, message: message, error: error }
  end
end