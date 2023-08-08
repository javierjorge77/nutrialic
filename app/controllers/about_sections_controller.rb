class AboutSectionsController < ApplicationController
    def new
        @professional = Professional.find(params[:professional_id])
        @about_section = @professional.build_about_section
        render partial: 'form', locals: { professional: @professional, about_section: @about_section }
      end

    def create
        @professional = Professional.find(params[:professional_id])
        @about_section = @professional.build_about_section(about_section_params)
    
        if @about_section.save
          # Redirigir a la página del profesional o a donde desees
          redirect_to show_by_username_path(id: @professional.username), notice: 'Sección "Acerca de mí" creada exitosamente.'
        else
          flash.now[:alert] = 'Hubo un error al crear la sección "Acerca de mí".'
          render 'new'
        end
      end

      def edit
        @professional = Professional.find(params[:professional_id])
        @about_section = @professional.about_section
        render partial: 'edit_form', locals: { professional: @professional, about_section: @about_section }
      end

      def update
        @professional = Professional.find(params[:professional_id])
        @about_section = @professional.about_section
    
        if @about_section.update(about_section_params)
          # Redirigir a la página del profesional o a donde desees
          redirect_to show_by_username_path(id: @professional.username), notice: 'Sección "Acerca de mí" actualizada exitosamente.'
        else
          flash.now[:alert] = 'Hubo un error al actualizar la sección "Acerca de mí".'
          render 'edit'
        end
      end

      def destroy
        @professional = Professional.find(params[:professional_id])
        @about_section = @professional.about_section
    
        if @about_section.destroy
            redirect_to show_by_username_path(id: @professional.username), notice: 'Sección "Acerca de mí" eliminada exitosamente.'
        else
            redirect_to show_by_username_path(id: @professional.username), notice: 'Ocurrio un problema eliminando la sección "Acerca de mí".'
        end
      end
    
      private
    
      def about_section_params
        params.require(:about_section).permit(:content)
      end
end