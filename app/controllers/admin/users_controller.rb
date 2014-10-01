class Admin::UsersController < ApplicationController
  def index
    if current_user && current_user.admin == 1
      @users=User.all
      @users = @users.page(1).per(20)
    else
      redirect_to '/', notice: "Must be admin!!"
    end
  end
end
