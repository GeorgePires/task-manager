Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/new'
  get 'tasks/edit'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  match 'about', to: 'home#about', via: :get
end
