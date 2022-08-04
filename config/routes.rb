Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "application#index", as: :root
  get "/login", to: "application#login", as: :create_login
  get "/logout", to: "application#logout"
  resources :containers, only: %i[show create]

  post "/items/:id/destroy", to: "items#destroy", as: :destroy_item
  resources :items, only: %i[create show]
end
