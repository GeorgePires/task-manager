Rails.application.routes.draw do
  resources :tasks do 
    member do
      get :delete
    end
  end
  
  resources :categories do
    member do
      get :delete
    end
  end
  
  root 'home#index'
  match 'about', to: 'home#about', via: :get
end
