class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  
  def invalid_params
    render json: { data: {}, error: 'invalid parameters' }, status: :bad_request
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_invalid_record(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_error(error, status = :bad_request)
    render json: { message: "your request cannot be completed", error: error}, status: status
  end


  def validate_id
    id = :"#{params.keys.grep(/id/)[0]}"
    error = "String not accepted as id"
    render_error(error) if params[id].to_i == 0
  end
end
