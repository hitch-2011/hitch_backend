class ApplicationController < ActionController::API
  def get_zip(address)
    address.split(',').map { |i| i[-5..-1] }[2].to_i
  end
end
