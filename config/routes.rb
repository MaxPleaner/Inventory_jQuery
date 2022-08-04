Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "application#index", as: :root
  get "/login", to: "application#login", as: :create_login
  get "/logout", to: "application#logout"
  resources :containers, only: %i[show create]

  post "/move_object", to: "application#move_object", as: :move_object

  post "/items/:id/destroy", to: "items#destroy", as: :destroy_item
  post "/items/bulk_create", to: "items#bulk_create", as: :bulk_create_items
  resources :items, only: %i[create show update]
end
