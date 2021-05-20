Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get '/address_validator', to: 'address_validator#address_validator_request'
      
      namespace :users do
        post '/:id/rides', to: 'rides#create'
      end

      resources :rides, only: [:index]

      resources :users, only: [:create, :show]

    end
  end
end
