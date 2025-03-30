class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]
  def show
    redirect_to root_path unless user_owns_profile?
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: "User was successfully updated."
    else
      render :show
    end
  end
  private

  def user_params
    if current_user.super_admin? || current_user.admin?
      params.require(:user).permit(:full_name, :email, :avatar, :role, :phone, :birth_date, :salary, :shift_start, :shift_end)
    else
    params.require(:user).permit(:full_name, :email, :avatar, :phone, :birth_date)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_owns_profile?
    current_user == @user
  end
end
