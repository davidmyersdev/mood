Rails.application.routes.draw do
  root 'welcome#index'

  resources :push_subscriptions, only: [:create]

  resources :users, only: [] do
    collection do
      get :current
      post :sign_in
    end
  end
end
