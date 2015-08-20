class LikesController < ApplicationController

  before_action :require_login

  def create
    like = Like.create(user_id: params['user_id'], tutorial_id: params['tutorial_id'], completed: false)
    render json: like
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

end
