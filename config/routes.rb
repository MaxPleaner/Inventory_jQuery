Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "application#index"
  get "/login", to: "application#login", as: :create_login
  get "/logout", to: "application#logout"
end
