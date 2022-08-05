Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "application#index", as: :root
  get "/login", to: "application#login", as: :create_login
  get "/logout", to: "application#logout"

  get "/search_items", to: "items#search", as: :search

  post "/containers/:id/remove", to: "containers#destroy", as: :delete_container
  resources :containers, only: %i[show create]

  post "/move_object", to: "application#move_object", as: :move_object

  post "/item/:id/tags", to: "items#add_tag", as: :item_tag
  post "/item/:id/remove_tag", to: "items#remove_tag", as: :remove_item_tag

  post "/items/:id/destroy", to: "items#destroy", as: :destroy_item
  post "/items/bulk_create", to: "items#bulk_create", as: :bulk_create_items
  resources :items, only: %i[create show update]
end
