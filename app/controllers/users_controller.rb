class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      user.generate_token
      render json: user.to_json(except: [:created_at, :updated_at, :password_digest])
    else
      render json: { errors: :user.errors.as_json }, status: 422
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

  def authenticate(params)
    authenticate_or_request_with_http_token do |token|
      dbToken = User.find_by(token: params[:token])
      dbToken && token == dbToken
    end
  end

end
