class UsersController < ApplicationController

  def new
    @user = User.new
  end

   def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id unless current_user.admin == true# auto log in
      redirect_to movies_path
    else
      render :new
    end
  end

  def destroy
    User.where(params[:user_to_delete]).destroy
    redirect_to movies_path, notice: "Adios!"
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_index_path
    else
      render :edit
    end
  end
  

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation,:admin)
  end

end