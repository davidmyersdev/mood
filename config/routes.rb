Rails.application.routes.draw do
  root 'welcome#index'

  get :sign_up, to: 'welcome#sign_up'

  resources :dashboard, only: [:index]

  resources :entries, only: [:create, :index, :new]

  resources :ephemeral, only: [] do
    collection do
      get :authenticate_by_notification
      get :log_me_in
      get :notify_me
    end
  end

  resources :push_subscriptions, only: [:create] do
    collection do
      post :log_me_in
    end
  end

  resources :users, only: [] do
    collection do
      get :current
      get :sign_out
      post :sign_in
      post :sign_up
    end
  end
end
