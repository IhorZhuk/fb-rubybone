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
    user = User.find(params[:id])
    if user.id == current_user.id

      if params[:password].present?
        user.update(user_params)
      else
        user.update_attributes(:name => params[:name], :email => params[:email] )
      end

      unless user.valid?
        render json: {
          errors: user.errors
        }, status: :unprocessable_entity
      end

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