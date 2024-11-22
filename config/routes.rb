Rails.application.routes.draw do
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


  # authorizations
  get "/login", to: "authorizations#login"
  get "/signup", to: "authorizations#sign_up"
end
