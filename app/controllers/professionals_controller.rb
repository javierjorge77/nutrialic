class ProfessionalsController < ApplicationController

  def new
    @professional = Professional.new
  end

  def create
    @professional = Professional.new(professional_params)
    @professional.user = current_user
    @professional.save
    redirect_to professional_path(@professional)
  end

  def index
    @professionals= Professional.all
  end

  def show
    @professional = Professional.find(params[:id]) #
  end


  def edit
  end

  def destroy
    @professional = Professional.find(params[:id])
    @professional.destroy
    # No need for app/views/professionals/destroy.html.erb
    redirect_to professionals_path, status: :see_other

  end


  private


  def professional_params
    params.require(:professional).permit(:branch, :adress, :diploma, :first_cost, :follow_cost, :photo)
  end


end
