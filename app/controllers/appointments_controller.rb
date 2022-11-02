class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    @professional = Professional.find(params[:professional_id])
  end

  def create
    @professional = Professional.find(params[:professional_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    @appointment.professional = @professional
    if @appointment.save
      redirect_to "/"
    else
      render :new, status: :unprocessable_entity
    end
  end

private

def appointment_params
  params.require(:appointment).permit(:first, :online, :time)
end


end
