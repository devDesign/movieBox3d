class Admin::UsersController < ApplicationController
  def index
    if current_user && current_user.admin == true
      @users=User.all
      @users = @users.page(1).per(20)
    else
      redirect_to '/', notice: "Must be admin!!"
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:format])
  end


  def destroy
    @user = User.find(params[:format])
    @user.destroy
    redirect_to admin_users_index_path, notice: "#{@user.full_name}Adios!"
  end

end
