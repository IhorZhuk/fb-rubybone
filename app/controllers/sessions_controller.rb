class SessionsController < ApplicationController
  respond_to :json

  def new
    # renders login screen with signup and loign forms
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
    else
    render json: { 
      errors: {
        user: ["User with such email doesn't exist"]
      }
    }, status: :not_found
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end