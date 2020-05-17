Rails.application.routes.draw do
  root 'welcome#index'

  get :sign_up, to: 'welcome#sign_up'

  resources :dashboard, only: [:index]

  resources :entries, only: [:create, :index, :new]

  resources :ephemeral, only: [] do
    collection do
      get :notify_me
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
