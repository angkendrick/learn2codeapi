class LikesController < ApplicationController

  before_action :require_login

  def create
    like = Like.create(secure_params)
    render json: like.to_json(except: [:created_at, :updated_at])
  end

  def show
    @likes = Like.where(user_id: params['id']) #not really needed
  end

  def destroy
    #userLike = User.find(get_id).likes.find_by(tutorial_id:params['id'])
    like = Like.find(params['id'])

    if like.destroy
      render json: like.to_json(except: [:created_at, :updated_at])
    else
      render json: { errors: :like.errors.as_json }, status: 422
    end
  end

  protected

  def secure_params
    params.require(:like).permit(:tutorial_id, :completed).merge(user_id: get_id)
  end

end
