class ReviewsController < ApplicationController

before_action :require_signin
before_action :set_movie


def index

    @reviews = @movie.reviews #And now we have a variable that points to the right movie object, and calls the reviews method on it. Remember, when we created a model called review with a reference in it to the movie model, rails created a new method called reviews for any movie object (using the same name as the model, but plural) and so we could call 'movie.reviews' in Rails console sessions to get all the review assosciated with the movie (we defined the movie, with movie = Movie.find(2), for instance). So this @reviews = @movie.reviews is simply doing the same thing in our Rails console sessions. 
end


def show
@review = @movie.reviews.find(params[:id])
end




def edit
@review = @movie.reviews.find(params[:id])
end


def update
  @review = @movie.reviews.find(params[:id])
  if @review.update(review_params)

    redirect_to movie_reviews_path, notice: "Review is updated!"
  else
    render :edit   
  end
end  


def new
    @review = @movie.reviews.new 
end




def create

   @review = @movie.reviews.new(review_params)
   @review.user = current_user
   if @review.save
       redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
   else 
    render :new
   end
end





def destroy
  @review = @movie.reviews.find(params[:id])
  @review.destroy
  redirect_to movie_reviews_path, notice: "Review is deleted!"


end    



private

def set_movie
    @movie = Movie.find(params[:movie_id]) # (NOTE: we used to have this line at the start of each method in this controller, but now we added 'set_movie' outside the methods, and call it as a before_action at top of the controller. This means set_movie will be called everytime a method (outside of private) runs, and cuts down on duplicated code. ANYWAY, here's explaination for @movie = Movie.find(params[:movie_id]:when someone goes to localhost3000/movies/2/reviews, we need to figure out which movie that is. And hey, it's contained in the URL already. And the router knows this and passes along this information in the form of a paramater, which you can call.  So we set up an instance variable that finds the movie using the the param we get from the router....and that's contained in params[:movie_id]. So now we have a variable that points to the particular movie we want.
end

def review_params
  params.require(:review).permit(:comment, :stars)
end
end