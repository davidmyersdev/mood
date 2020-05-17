Rails.application.routes.draw do
  root 'welcome#index'

  get :sign_out, controller: :users
  get :sign_up, controller: :welcome
  post :sign_in, controller: :users
  post :sign_up, controller: :users

  resources :dashboard, only: [:index]

  resources :entries, only: [:create, :index, :new]

  resources :ephemeral, only: [] do
    collection do
      get :notify_me
    end
  end

  namespace :api do
    resources :subscriptions, only: [:create]
  end
end
