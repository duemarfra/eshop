Rails.application.routes.draw do
  namespace :authentication, path: "", as: "" do
    resources :users, only: [:new, :create], path: "/register", path_names: { new: "/" }
    resources :sessions, only: [:new, :create, :destroy], path: "/login", path_names: { new: "/" }
  end

  resources :favorites, only: [:index, :create, :destroy], param: :item_id
  resources :shoppings, only: [:index, :create, :destroy], param: :item_id
  resources :users, only: :show, path: "/user", param: :username
  resources :admins, only: [:index, :show, :edit, :update, :destroy], path: "/admins"
  resources :categories, except: :show
  resources :items, path: "/"
  patch "/user/:id", to: "admins#update"
  get "/shoppings/sale", to: "shoppings#sale"
end
