class GenresController < ApplicationController

    def index
        @genres = Genre.all
        
    end


def show
    @genre = Genre.find(params[:id])
@movies = @genre.movies
# @review = @movie.reviews.find(params[:id])
end




end
