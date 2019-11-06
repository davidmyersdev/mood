Rails.application.routes.draw do
  root 'welcome#index'

  resources :notifications, only: [] do
    scope module: :notifications do
      resources :responses, only: [:create]
    end
  end

  resources :push_subscriptions, only: [:create]

  resources :users, only: [] do
    collection do
      get :current
      post :sign_in
    end
  end
end
