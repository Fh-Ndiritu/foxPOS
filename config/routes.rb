Rails.application.routes.draw do
  devise_for :users
  get "receipts/show/:id" => "receipts#show", as: :show_receipt, defaults: { format: :pdf }
  get "receipts/print"
  resources :items

  resources :orders do
    get "/options/:category_id" => "orders#options", as: :options
  end

  get "home/menu"

  resources :categories do
    resources :products, only: [ :index, :create ]
  end
  resources :products

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#menu"
end
