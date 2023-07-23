class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:destroy]
  #DELETE /resource
  def destroy
    user = current_user
    if user.nutritionist
      flash[:notice] = "Para eliminar tu cuenta de usuario primero debes eliminar tu cuenta professional"
      redirect_to edit_professional_path(current_user.professional.id)
    else 
      sign_out(user)
      if user.destroy
        flash[:notice] = "Cuenta eliminada exitosamente"
        redirect_to root_path 
      end
    end
  end
end
