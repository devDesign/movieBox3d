class Admin::BaseController < ApplicationController


  def switch
    @user = User.find(params[:id])
    session[:admin] = current_user.id
    session[:user_id] = @user.id
    redirect_to :back, notice: 'GHOST DOG'
  end

end
