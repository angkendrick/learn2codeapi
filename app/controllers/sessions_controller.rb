class SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      user.generate_token
      render json: user
    else
      render json: { error: 'Username & Password mismatch' }, status: 401
    end

  end

end
