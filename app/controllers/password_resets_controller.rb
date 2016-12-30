class PasswordResetsController < ApplicationController

  respond_to :json

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      # response with error
    elsif params[:email] == @user.email
       if @user.update(password_params)
          # response with ok
       else
          render json: {
            errors: @user.errors
          }, status: :unprocessable_entity
       end
    end
  end

  private

    def password_params
      params.permit(:email, :password, :password_confirmation)
    end
end
