Rails.application.routes.draw do
  resources :users, only: [] do
    collection do
      get :current
      post :sign_in
    end
  end
end
