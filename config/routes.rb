Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :rooms, only: [:new, :create, :show]
  resources :users, only: [:edit, :update, :show]
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
end
