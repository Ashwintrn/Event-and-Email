Rails.application.routes.draw do
  
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', registration: 'register', sign_up: 'create_account' } 

  resources :events, only: [:create, :index]

  root "home#index"
end
