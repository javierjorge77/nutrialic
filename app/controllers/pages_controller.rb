class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home


  def home
    if current_user
      @user = current_user
    end
    
    @professionals= Professional.all
  end
end
