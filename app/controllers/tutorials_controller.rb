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
    @tutorial = Tutorial.find(params[:id])
    #render json: @tutorial.to_json(include: :user, except: [:created_at, :updated_at])
  end

  def update
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.update_attributes(secure_params)
      render json: { message: 'Update OK!', status: 200 }
    else
      render json: { error: 'Failed to update', status: 500 }
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.destroy
      render json: { message: 'Delete OK!', status: 200 }
    else
      render json: { error: 'Failed to delete', status: 500 }
    end
  end

  protected

  def secure_params
    params.require(:tutorial).permit(:user_id, :name, :description, :url, :tutorialimage, :cost, :difficulty, :format, :company)
  end

end