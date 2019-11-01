Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [] do
    collection do
      get :current
      post :sign_in
    end
  end
end
