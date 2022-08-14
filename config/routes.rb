Rails.application.routes.draw do

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'


  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :jobs do
      resources :jobapps
    end
  end

end