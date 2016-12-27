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

  def index
    respond_with current_user.to_json(only: [:email, :name, :id])
  end

  def show
    respond_with current_user.to_json(only: [:email, :name, :id])
  end

  def update
    # TODO
    #proper response
    if params[:password].present?
      respond_with current_user.update(user_params)
    else
    #TODO
    # how to update params
      respond_with current_user.update_attributes(:name => params[:name], :email => params[:email] )
    end
  end

  def destroy
    respond_with current_user.destroy
  end

private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end