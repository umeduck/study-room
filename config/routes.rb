Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :update]
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
end
