Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :recipes, except: %i[destroy update] do
    delete '/user/:id' => 'recipes#destroy', as: 'delete'
    patch '/user/:id' => 'recipes#update', as: 'update'
    post '/user/:id' => 'recipes#add_favourite', as: 'add_favourite'
    patch '/vote/:action' => 'recipes#upvote_or_downvote', as: 'upvote_or_downvote'
    post '/user/:id/review' => 'reviews#add_review', as: 'add_review'
  end
  get '/user/:id/favourites' => 'recipes#user_favourites', as: 'user_favourites'

  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/activate/:token', to: 'users#edit', as: 'activate'
end
