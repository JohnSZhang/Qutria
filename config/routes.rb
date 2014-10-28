Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  root to: "users#index"
end
