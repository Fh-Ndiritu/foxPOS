class Admin::UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: %i[show edit update destroy]

  def index
    # @users = User.where.not(id: current_user.id)
    @users = User.all
  end

  def edit
  end

  def new
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated'
    else
      render :edit
    end
  end

  def destroy

  end


  private

  def authorize_admin
    return unless !current_user.can_manage?
    redirect_to root_path, alert: 'Admins only!'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :phone, :birth_date, :salary, :shift_start, :shift_end, :avatar, :role, :email)
  end
end
