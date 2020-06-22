class SessionsController < ApplicationController


def new
    
end




def create
user = User.find_by(email: params[:email])
if user && user.authenticate(params[:password])
session[:user_id] = user.id
redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
session[:intended_url] = nil
# see video two of lesson 33, at around 9 minutes
else
flash.now[:alert] = "Invalid email/password combination!"
render :new

end

end





def destroy
  session[:user_id] = nil
redirect_to movies_url, notice: "You're now signed out!"

end


end
