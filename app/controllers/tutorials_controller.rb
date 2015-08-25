class TutorialsController < ApplicationController

  before_action :require_login, only: [:create, :update, :destroy]

  def index
    @tutorials = Tutorial.all
    #render json: @tutorials.to_json(include: :subjects, except: [:created_at, :updated_at])
  end

  def create
    @tutorial = Tutorial.new(secure_params)

    if @tutorial.save
      render json: @tutorial.to_json(except: [:created_at, :updated_at])
    else
      render json: { errors: :@tutorial.errors.as_json }, status: 422
    end
  end

  def show
    user_id = get_id
    @tutorial = Tutorial.find(params[:id])
    @user_like = Tutorial.find(params[:id]).likes.where(user_id:user_id)
    @user_review = Tutorial.find(params[:id]).reviews.where(user_id:user_id)
    ts = TutorialSubject.where(subject_id:@tutorial.subjects[0].id)

    @related_tutorials = Tutorial.where(id:ts.map(&:tutorial_id))

    #render json: @tutorial.to_json(include: :user, except: [:created_at, :updated_at])
  end

  def update
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.update_attributes(secure_params)
      render 'show'
    else
      render json: { errors: :@tutorial.errors.as_json }, status: 422
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.destroy
      @tutorial = Tutorial.all
      render 'index'
    else
      render json: { error: 'Failed to delete', status: 500 }
    end
  end

  protected

  def secure_params
    params.require(:tutorial).permit(:user_id, :name, :description, :url, :tutorialimage, :cost, :difficulty, :format, :company)
  end

end