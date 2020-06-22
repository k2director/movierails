class Movie < ApplicationRecord


    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy

    has_many :fans, through: :favorites, source: :user
    has_many :critics, through: :reviews, source: :user #this is the standard format to create associations in a single database query. First we name the association like fans or critics, then we specify through which database table we're going to be using to make associations (ie, favorites is used associate a movie with users who have favorited it,) and then we specify the source model that we're looking at, so it's :user in this case. 

    has_many :characterizations, dependent: :destroy
    has_many :genres, through: :characterizations



    validates :title, :released_on, :duration, presence: true

    validates :description, length: { minimum: 25 }

    validates :total_gross, numericality: 
                            { greater_than_or_equal_to: 0 }

    validates :image_file_name, format: {
                                with: /\w+\.(jpg|png)\z/i,
                                message: "must be a JPG or PNG image"
}

RATINGS = %w(G PG PG-13 R NC-17)

validates :rating, inclusion: {in: RATINGS }



scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }

scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on desc") }

scope :recent, ->(max=5) { released.limit(max) }

scope :hits, ->{ where("total_gross >= ?", 300000000).order("total_gross desc") }

scope :flops, ->{ where("total_gross < ?", 225000000).order("total_gross asc") }


    # def self.released // note: this was removed when we moved the functionality into a scope, as seen above. 
    #     # where("total_gross > ?", 1000000000).order("total_gross desc")
    #     where("released_on < ?", Time.now).order("released_on desc")
    #     # Movie.where(rating: "PG")
    #     # where("duration > ?", 140).order("duration desc")
    # end


    def flop?
        total_gross.blank? || total_gross < 225000000
    end


    # def self.hits / also turned into scopes
    #   where("total_gross >= ?", 300000000).order("total_gross desc")
    # end


    # def self.flops
    #   where("total_gross < ?", 225000000).order("total_gross asc")
    # end

    def self.recently_added
      order("created_at desc").limit(3)
    end

    def average_stars
    reviews.average(:stars) || 0.0
  end    

    
    
end
