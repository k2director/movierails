class ApplicationController < ActionController::Base

private



    def current_user
      User.find(session[:user_id]) if session[:user_id]# thats a handy way to tack on an if statement at the end...so this will be returned only if there's a user id in the session. And the only way a user id is in the session is if the user is logged in. So this finds the user by reading the session info. 
    end

    helper_method :current_user

    def current_user?(user)
    current_user == user
    end

helper_method :current_user?


def current_user_admin?
    current_user && current_user.admin?
end

helper_method :current_user_admin?


def require_signin
  unless current_user
    #rememebr, this method returns a user object if there's a signed in user. So this is saying "redirect to new session url UNLESS current user is true (because that tells us were already logged in)"

    session[:intended_url] = request.url 
    # this line uses rails request_url built in method to store the url that person tried to get to before being told to sign in. It does this so once you sign in, it takes you to the page you wanted. its storing the info in a hash. 

    redirect_to new_session_url, alert: "Please sign in first!"
    #note: by creating this require_signin method that runs for ALMOST any action (except create and new to create accounts), we prevent any other action from working unless it has a session present.

  end
end



def require_admin
    unless current_user_admin?
    redirect_to movies_url, alert: "Sorry, only admins!!"  

    end

end

end
