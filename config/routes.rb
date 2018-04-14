Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # namespace the controllers without affecting the URI. New namespace are placed above
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :recipes, except: %i[destroy update] do
      delete '/user/:id' => 'recipes#destroy', as: 'delete'
      patch '/user/:id' => 'recipes#update', as: 'update'
      post '/user/:id' => 'recipes#add_favourite', as: 'add_favourite'
      patch '/user/:id/vote/:type' => 'recipes#upvote_or_downvote', as: 'upvote_or_downvote'
      post '/user/:user_id/review' => 'reviews#add_review', as: 'add_review'
    end
    get '/search' => 'recipes#search', as: 'search'
    get '/user/:id/favourites' => 'recipes#user_favourites', as: 'user_favourites'
    get '/recipe/most-votes' => 'recipes#most_votes', as: 'most_votes'
  end

  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/activate/:token', to: 'users#edit', as: 'activate'
  post '/password-reset', to: 'users#reset', as: 'password_reset'
  patch '/reset/:token', to: 'users#update', as: 'reset'
end
