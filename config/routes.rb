Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]

  resources :questions
  resources :answers, only: [:destroy, :edit, :update, :create]

  resources :tags, only: [:destroy, :edit, :update, :create, :index, :show] do
    resource :favorite, only: [:create, :destroy]
  end
  resources :taggables, only: [:create, :destroy]
  resource :favorite, only: [:show]

  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :votes, only: [:create]
  delete "votes", to: "votes#destroy"

# Backbone App
  namespace :api do
    resource :session, only: [:create, :destroy] do
      get "current", to: "sessions#current"
    end
    resources :users, only: [:create, :destroy, :index, :show, :update]
    resources :questions, only: [:create, :show, :index, :update, :destroy]
  end

# Switch between rails and backbone here
  root to: "apps#index"
end
