class Api::V1::UsersController < ApplicationController
  before_action :validate_id, only: [:show]

  def show
    user = User.find(params[:id])
    render json: ProfileSerializer.new(user)
  end

end
