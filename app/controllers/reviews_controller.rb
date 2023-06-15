class ReviewsController < ApplicationController

    def create
        @review = Review.new(review_params)
        if @review.save
            flash[:notice] = "Comment was successfully added"
            redirect_to professionals_path
        else  
            flash[:notice] = "Comment was not added"
        end
        
    end

    def destroy
        @review = Review.find(params[:id])
        if @review.destroy
            flash[:notice] = "El comentario ha sido eliminado correctamente"
            redirect_to root_path
        else 
            flash[:notice] = "A ocurrido un error al eliminar el comentario"
            redirect_to root_path        
        end
        
    end

    def update
        @review = Review.find(params[:id])
        
        if @review.update(review_params)
            flash[:notice] = "El comentario ha sido actualizado correctamente"
            redirect_to root_path
        else 
            flash[:notice] = "Ocurrió un error al actualizar el comentario"
            redirect_to root_path        
        end
    end


    private 

    def review_params
        params.require(:review).permit(:score, :comment, :professional_id, :user_id)
    end
end