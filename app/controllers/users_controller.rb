class UsersController < ApplicationController

before_action :require_signin, except: [:new, :create]
# this means anybody can run a new or create action before being signed in...lets them open a new account before being signed in!


before_action :require_correct_user, only: [:edit, :update, :destroy]


def index
  @users = User.all
end    


def show
  @user = User.find(params[:id])
  @reviews = @user.reviews
  @favorite_movies = @user.favorite_movies
end    


def new
  @user = User.new
end    

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to @user, notice: "Thanks for signing up!"  
    
  else
    render :new
  end  
end





  def edit
    # @user = User.find(params[:id])#commenting out this line because we now have @user assigned in Private below, which is run only for update, edit and destroy by the before_action at the top. 
  end



  def update
    # @user = User.find(params[:id])#commenting out this line because we now have @user assigned in Private below, which is run only for update, edit and destroy by the before_action at the top. 
    if @user.update(user_params)
      redirect_to @user, notice: "You updated your profile!"
    else
      render :edit
    end
  end



  def destroy
    # @user = User.find(params[:id]) #commenting out this line because we now have @user assigned in Private below, which is run only for update, edit and destroy by the before_action at the top.     
    @user.destroy
    session[:user_id] = nil

    redirect_to movies_url, alert: "Account deleted!"
  end



private

def require_correct_user
  @user = User.find(params[:id])
  # unless current_user == @user #this checks to see if current_user is the same user that the current_user might trying to modify, like editing or deleting an account. NOTE: this line now superfluous because we are, in line below, calling a new current_user? method that is availabel everywhere, and returns true if current_user == @user. 
    redirect_to movies_url unless current_user?(@user)

end

  def user_params
    params.require(:user).
          permit(:name, :username, :email, :password, :password_confirmation)
  end  

end
