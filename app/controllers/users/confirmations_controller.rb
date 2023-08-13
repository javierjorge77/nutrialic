class Users::ConfirmationsController < Devise::ConfirmationsController
    def create
        self.resource = resource_class.find_by_email(resource_params[:email])
    
        if resource.nil?
            flash[:alert] = "No hay registros con este correo."
            redirect_to new_user_confirmation_path
        elsif resource.confirmed?
            flash[:alert] = "Este correo electrónico ya ha sido confirmado."
            redirect_to new_user_confirmation_path
        else
            self.resource = resource_class.send_confirmation_instructions(resource_params)
            if successfully_sent?(resource)
                flash[:notice] = "Las instrucciones se han reenviado al correo electrónico ingresado."
                redirect_to root_path
            else
                flash[:alert] = "Error al reenviar las instrucciones de confirmación."
                render :new
            end
        end
    end
    

    def after_resending_confirmation_instructions_path_for(resource_name)
        flash[:notice] = "Las instrucciones se han reenviado al correo electrónico ingresado."
        root_path
    end
end