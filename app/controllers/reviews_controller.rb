class ReviewsController < ApplicationController

  before_action :require_login

  def create
    review = Review.new(secure_params)

    if review.save
      render json: review.to_json(except: [:created_at, :updated_at])
    else
      render json: { errors: :review.errors.as_json }, status: 422
    end
  end

  def destroy
    review = Review.find(params['id'])

    if review.destroy
      render json: review.to_json(except: [:created_at, :updated_at])
    else
      render json: { errors: :review.errors.as_json }, status: 422
    end
  end

  protected

  def secure_params
    params.require(:review).permit(:user_id, :tutorial_id, :rating, :description)
  end

end
