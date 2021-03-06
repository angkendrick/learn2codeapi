class UsersController < ApplicationController

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     # redirect_to tutorials_path, notice: "Tutorial, #{@tutorial.name} submitted"
  #     render json: @user
  #   else
  #     render json: {}
  #   end
  # end

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
    @user = User.find(get_id)
    @tutorials = Tutorial.all
    if @user
      #render on view
    else
      render json: { errors: :@user.errors.as_json }, status: 422
    end
  end

  def update
    user = User.find(get_id)
    if user.update_attributes(user_params)
      render json: user.to_json(except: [:token, :created_at, :updated_at, :password_digest])
    else
      render json: { errors: :user.errors.as_json }, status: 422
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
