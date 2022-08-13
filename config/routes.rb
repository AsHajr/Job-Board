Rails.application.routes.draw do

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :jobs do
    resources :jobapps
  end

end