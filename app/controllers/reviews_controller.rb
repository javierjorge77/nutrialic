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

    private 

    def review_params
        params.require(:review).permit(:score, :comment, :professional_id, :user_id)
    end
end