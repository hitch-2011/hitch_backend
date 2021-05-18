Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :users do
        post '/:id/rides', to: 'rides#create'
      end

      resources :rides, only: [:index]
    end
  end
end
