require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => "/sidekiq"

  namespace :admin do
    resources :loans, only: [ :index, :show, :update ] do
      member do
        patch :approve
        patch :reject
        # get :filters
      end
      collection do
        get :filters
      end
    end
  end
  namespace :user do
    resources :loans, only: [ :index, :new, :create, :show, :update ] do
      member do
        patch :accept
        patch :request_readjustment
        patch :reject
        patch :repay
        get :adjustment_details
      end
    end
  end
  # resources :home, only: [:index]

  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
