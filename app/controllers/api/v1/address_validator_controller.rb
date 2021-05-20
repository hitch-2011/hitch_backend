class Api::V1::AddressValidatorController < ApplicationController
  def address_validator_request
    render json: AddressValidatorFacade.validate_address(params[:origin], params[:destination])
  end
end