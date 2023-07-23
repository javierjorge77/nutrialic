
class ProfessionalsController < ApplicationController

  def create
    @professional = Professional.new(professional_params)
    @professional.user = current_user
    @professional.save
    current_user.nutritionist = true
    current_user.save
    redirect_to show_by_username_path(@professional.username)
  end

  def index
    if params[:search].present?
      #@professionals = Professional.search_by_fields(params[:search]).includes(:reviews)
      @pagy, @professionals = pagy(Professional.search_by_fields(params[:search]).includes(:reviews), items: 6)
    else
      #@professionals = Professional.all.includes(:reviews)
      @pagy, @professionals = pagy(Professional.all.includes(:reviews), items: 6)
    end
    @markers = @professionals.map do |professional|
      {
        lat: professional.latitude,
        lng: professional.longitude
      }
    end
  end

  def show
    @current_user = current_user
    @professional = Professional.find_by(username: params[:id])
    @reviews = @professional.reviews
    if @reviews && @reviews.length > 0
      @final_score = @reviews.average(:score).to_f.round(1)
    else 
      @final_score = 0
    end
    @marker = {
      lat: @professional.latitude,
      lng: @professional.longitude
    }
    puts @professional.latitude 
    puts @professional.longitude
  end


  def edit
    @professional = Professional.find(params[:id])
    @marker = {
      lat: @professional.latitude,
      lng: @professional.longitude
    }
  end

  def update
    @professional = Professional.find(params[:id])
    @professional.update(professional_params) # Will raise
    redirect_to professionals_path, status: :see_other
  end

  def destroy
    @professional = Professional.find(params[:id])
    if !@professional.appointments.exists?
      request = ProfessionalAccountRequest.find_by(username: @professional.username)
      request.destroy
      @professional.destroy
      current_user.nutritionist = false
      current_user.save
      flash[:notice] = "Tu cuenta professional ha sido eliminada correctamente"
      redirect_to root_path, status: :see_other
    else  
      flash[:notice] = "No puedes eliminar tu cuenta debido a que tienes citas agendadas"
      redirect_to professional_appointments_path(current_user.professional.id)
    end
  end


  private


  def professional_params
    params.require(:professional).permit(:username, :branch, :adress, :diploma, :first_cost, :follow_cost, :photo, :startAttendingTime, :endAttendingTime, :latitude, :longitude)
  end


end
