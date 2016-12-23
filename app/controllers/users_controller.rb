class UsersController < ApplicationController
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      Category.create(
       user: current_user,
       title: 'Uncategorized'
      )
    else
      respond_with user
    end
  end

private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end