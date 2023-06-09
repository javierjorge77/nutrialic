
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

    redirect_to nutriologos_path(@professional)
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
    @current_user = current_user
    @professional = Professional.find(params[:id])
    @reviews = @professional.reviews
    if @reviews && @reviews.length > 0
      @total_score = 0
      @reviews.each do |review|
        @total_score += review.score 
      end
      @final_score = (@total_score / @reviews.length).round(1)
    else 
      @final_score = 0
    end

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
    params.require(:professional).permit(:branch, :adress, :diploma, :first_cost, :follow_cost, :photo, :startAttendingTime, :endAttendingTime)
  end


end
