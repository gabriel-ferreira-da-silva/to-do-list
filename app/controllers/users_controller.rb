class UsersController < ApplicationController
  def index
    response = NodeUserService.all_users
    @users = JSON.parse(response.body)
  end

  def show
    response = NodeUserService.get_user(params[:id])
    @user = JSON.parse(response.body)
  end

  def create
    response = NodeUserService.create_user(user_params)
    if response.code == 201
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    response = NodeUserService.update_user(params[:id], user_params)
    if response.code == 200
      redirect_to user_path(params[:id]), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    response = NodeUserService.delete_user(params[:id])
    if response.code == 200
      redirect_to users_path, notice: 'User was successfully deleted.'
    else
      redirect_to users_path, alert: 'Failed to delete user.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
