Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/activate/:token', to: 'users#edit', as: 'activate'
end
