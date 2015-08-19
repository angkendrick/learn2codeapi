class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to tutorials_path
    else
      render json: { error: 'Failed to save to database', status: '500' }
    end
  end

  def show
    if current_user
      @user = User.find(current_user.id)
    else
      redirect_to new_session_path
    end

  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :avatar, :password, :password_confirmation)
  end

end
