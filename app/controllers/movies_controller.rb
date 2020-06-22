class MoviesController < ApplicationController



  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]


    def index

      case params[:filter]
      when "upcoming"
        @movies = Movie.upcoming
      when "hits"
        @movies = Movie.hits
      when "flops"
        @movies = Movie.flops
      else
        @movies = Movie.released
      end
      
        @genres = Genre.all
        # @movies = Movie.hits
        # @movies = Movie.flops
        # @movies = Movie.recently_added

        # .all is a method on the Movie model class that takes everything in that movie model and returns an array. So we're basically creating an instance variable that is an array of hashed objects derived from the movie model (remember a hash is an object that consists of key/value pairs). You can tell we're talking about a model when we say "Movie.all" because it's singular (Movie) not plural (Movies). And remember the Model class has access to application level data in the form of a database! The model translates data in a database into objects that RUby can work with. 
    end




    def show
  @movie = Movie.find(params[:id])
  @fans = @movie.fans
  @genres = @movie.genres
  if current_user
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
  end
end


    def edit
       @movie = Movie.find(params[:id]) 
    end





    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
      # flash[:notice] = "Movie successfully updated!"  //This line can acutally be combined with a redirect line, so see the line right below...
        redirect_to @movie, notice: "Movie successfully updated!"
      else
        render :edit
      end     
    end
    




    def new
        @movie = Movie.new

    end



    def create
      @movie = Movie.new(movie_params) # Creates a new object with the parameters from the form
      if @movie.save #if the movie is successfully saved, 
        redirect_to @movie, alert: "Movie successfully created!" #redirects to the regular index action (its the default of @movie)... the notice is shorthand for calling a flash (can be notice or alert)
      else  
        render :new #we don't want to redirect to the the New form page because we would lose the legit data that had already been submitted in the rejected form. So instead we use 'render :new' as in render the new record we're already dealing with. That takes us back to the form page. 
      end  
    end





    def destroy
      @movie = Movie.find(params[:id]) 
      @movie.destroy
      redirect_to movies_path
    end








private

def movie_params
        params.require(:movie).
          permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
end
end
