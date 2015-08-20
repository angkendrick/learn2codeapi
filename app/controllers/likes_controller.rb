class LikesController < ApplicationController

  before_action :require_login

  def create
    like = Like.create(secure_params)
    render json: like.to_json(except: [:created_at, :updated_at])
  end

  def show
    @likes = Like.where(user_id: params['id'])
  end

  def destroy
    like = Like.find(params['id'])

    if like.destroy
      @likes = Like.all
      render 'show'
    else
      render json: { errors: :like.errors.as_json }, status: 422
    end
  end

  protected

  def secure_params
    params.require(:like).permit(:user_id, :tutorial_id, :completed)
  end

end
