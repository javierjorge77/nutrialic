class ProfessionalAccountRequestsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:update], raise: false

    def new
        @professional_account_request = ProfessionalAccountRequest.new
        @marker = {}
    end

    def create
        @professional_account_request = ProfessionalAccountRequest.new(professional_account_request_params)
        @professional_account_request.user = current_user
        if @professional_account_request.save
            redirect_to root_path, notice: 'Tu peticion para cuenta profesional ha sido enviada, recibiras un correo de confirmacion cuando sea aprobada.'
        else
            render :new
        end
    end

    def update
        @professional_account_request = ProfessionalAccountRequest.find(params[:id])
        user = User.find(@professional_account_request.user_id)
        user.nutritionist = true
        if user.save && @professional_account_request.update(professional_account_request_params)
            redirect_to admin_professional_account_requests_path, notice: 'La cuenta se actualizo con exito'
        else
            render :edit
        end
    end
    
    private

    def professional_account_request_params
        params.require(:professional_account_request).permit(:username, :branch, :adress, :diploma, :first_cost, :follow_cost, :photo, :startAttendingTime, :endAttendingTime, :user_id, :confirmed, :latitude, :longitude)
    end
end