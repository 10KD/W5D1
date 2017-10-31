class UsersController < ApplicationController
  def new
    render :new
  end

  def index
    @all_users = User.all
  end

  def show
    @current_user = User.find_by(session_token: session[:session_token])
  end
  def create
    @user = User.new(user_params)

    if @user.save
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
