class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_unprocessable_entity_response
  
  def invalid_params
    render json: { data: {}, error: 'invalid parameters' }, status: :bad_request
  end
end
