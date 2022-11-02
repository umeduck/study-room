Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
  resources :users, only: [:edit, :update, :show]
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
end
