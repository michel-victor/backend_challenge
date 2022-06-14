Rails.application.routes.draw do
  # Routes for API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :disbursements, only: :index
    end
  end

  # Route for Sidekiq Web
  mount Sidekiq::Web => '/jobs'
end
