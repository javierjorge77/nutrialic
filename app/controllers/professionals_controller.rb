
class ProfessionalsController < ApplicationController

  def new
    @professional = Professional.new
  end

  def create
    @professional = Professional.new(professional_params)
    @professional.user = current_user
    @professional.save
    current_user.nutritionist = true
    current_user.save

    redirect_to professional_path(@professional)
  end

  def index
    @professionals= Professional.all
    @markers = @professionals.geocoded.map do |professional|
      {
        lat: professional.latitude,
        lng: professional.longitude
      }
    end
  end

  def show
    @professional = Professional.find(params[:id])
    @marker = {
      lat: @professional.latitude,
      lng: @professional.longitude
    }
  end


  def edit
    @professional = Professional.find(params[:id])
  end

  def update
    @professional = Professional.find(params[:id])
    @professional.update(professional_params) # Will raise
    redirect_to professionals_path, status: :see_other
  end

  def destroy
    @professional = Professional.find(params[:id])
    @professional.destroy
    current_user.nutritionist = false
    current_user.save
    # No need for app/views/professionals/destroy.html.erb
    redirect_to professionals_path, status: :see_other

  end


  private


  def professional_params
    params.require(:professional).permit(:branch, :adress, :diploma, :first_cost, :follow_cost, :photo)
  end


end
