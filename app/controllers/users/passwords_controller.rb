class Users::PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
  
    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      flash[:alert] = "No hemos encontrado este correo en los registros de usuarios."
      redirect_to new_user_password_path 
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
  
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message)
      sign_in(resource_name, resource)
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      flash[:alert] = "Las contraseñas no coinciden, vuelve a intentarlo"
      redirect_to request.referrer || edit_user_password_path(reset_password_token: params[:reset_password_token])
    end
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    flash[:notice] = "Las instrucciones para el cambio de contraseña se han enviado a tu correo."
    root_path
  end
end
