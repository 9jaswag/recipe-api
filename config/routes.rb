Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :recipes, :except => [:destroy, :update] do
    delete '/user/:id' => 'recipes#destroy', as: 'delete'
    patch '/user/:id' => 'recipes#update', as: 'update'
    patch '/user/:id' => 'recipes#user_favourites', as: 'user_favourites'
    patch '/vote/:action' => 'recipes#upvote_or_downvote', as: 'upvote_or_downvote'
  end

  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/activate/:token', to: 'users#edit', as: 'activate'
end
