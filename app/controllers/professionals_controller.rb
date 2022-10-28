class ProfessionalsController < ApplicationController

  def new
    @professional = Professional.new
  end

  def create
    @professional = Professional.new(professional_params)
    @professional.user = current_user
    @professional.save
    redirect_to user_path(@user)
  end

  def index
    @professionals= Professional.all
  end

  def show
    @professional = Professional.find(current_user) #
  end


  def edit
  end

  private


  def professional_params
    params.require(:professional).permit(:speciallity, :adress, :diploma, :first_cost, :follow_cost)
  end


end
