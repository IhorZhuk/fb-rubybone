class SessionsController < ApplicationController
  respond_to :json

  def new
    # renders login screen
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remeber_me] == 'on'
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
    else
      render json: { 
        errors: {
          user: ["User with such email doesn't exist"]
        }
      }, status: :not_found
    end
    # TODO
    # prevent unlogged user from accesing inner pages.add redirect
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to '/login'
  end

end