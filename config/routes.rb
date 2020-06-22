Rails.application.routes.draw do

  
  resources :genres
  # This root defines which page is our home page. 
  root "movies#index" 

get "movies/filter/:filter" => "movies#index", as: :filtered_movies #this lets us use a url format for filters like this: "http://localhost:3000/movies/filter/flops", (notice no question mark and presence of familiar slashes) in addition to the default url behavior which is: "http://localhost:3000/movies?filter=flops" (notice the question mark and no slashes) 


resources :movies do ||
    resources :reviews
    resources :favorites, only: [:create, :destroy]

end

  resource :session, only: [:new, :create, :destroy]
    get "signin" => "sessions#new"



  resources :users
    get "signup" => "users#new"









  # get "movies" => "movies#index"

  #   get "movies/new" => "movies#new"


  # get "movies/:id" => "movies#show", as: "movie"

  # get "movies/:id/edit" => "movies#edit", as: "edit_movie"

  # patch "movies/:id" => "movies#update" # we don't need to add anything else to this, like as:, because we're not trying to generate links to any other page. 

 

end
