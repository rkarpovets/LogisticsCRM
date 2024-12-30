Rails.application.routes.draw do
  resources :order_requests

  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'pages#index'

  resources :orders
  resources :customers
  resources :drivers
  resources :vehicles
  resources :products

  # pages
  get "/faq", to: "pages#faq"
  get "/about", to: "pages#about"
  get "/decisions_for_business", to: "pages#decisions_for_business"

end
