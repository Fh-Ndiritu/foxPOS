class Admin::UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: %i[show edit update destroy generate_reset_password_token]

  def index
    @users = current_user.manageable_users
  end

  def edit
  end

  def generate_reset_password_token
    @user.invalidate_old_tokens
    @raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
    @user.update!(reset_password_token: hashed_token, reset_password_sent_at: Time.current)

    # Send the reset email (but ensure it doesn't reset the token again)
    Devise.mailer.reset_password_instructions(@user, @raw_token).deliver_now

    flash[:notice] = "Reset password token generated"
    render partial: "admin/users/password_management"
  end

  def create
    password = SecureRandom.hex(8)
    @user = User.new(user_params.merge(password: password))
    if @user.save
      redirect_to admin_user_path(@user), notice: "User created"
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated"
    else
      render :edit
    end
  end

  def destroy
    @user.update hidden: true
    redirect_to admin_users_path, notice: "User deleted"
  end


  private

  def authorize_admin
    return unless !current_user.can_manage?
    redirect_to root_path, alert: "Admins only!"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :phone, :birth_date, :salary, :shift_start, :shift_end, :avatar, :role, :email)
  end
end
