class TutorialsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @tutorials = Tutorial.all
    render json: @tutorials
  end

  def create
    @tutorial = Tutorial.new(secure_params)
    #@tutorial.user_id = current_user.id
    #@tutorial.subjects << Subject.find((params[:tutorial_subjects][:subject_id]).to_i)

    if @tutorial.save
      render json: { message:'Save OK!', status: '200' }
    else
      render json: { error: 'Failed to save to database', status: '500' }
    end

  end

  def new
    @tutorial = Tutorial.new
    render json: { page: 'new'}
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
    render json: @tutorial
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    render json: @tutorial
  end

  def update
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.update_attributes(secure_params)
      render json: { message: 'Update OK!', status: '200' }
    else
      render json: { error: 'Failed to update', status: '500' }
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])

    if @tutorial.destroy
      render json: { message: 'Delete OK!', status: '200' }
    else
      render json: { error: 'Failed to delete', status: '500' }
    end
  end

  protected

  def secure_params
    params.require(:tutorial).permit(:user_id, :name, :description, :url, :tutorialimage, :cost, :difficulty, :format, :company)
  end

end