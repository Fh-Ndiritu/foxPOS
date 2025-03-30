class Admin::UsersController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: %i[show edit update destroy generate_reset_password_token]
  include ActionView::RecordIdentifier

  def index
    @users = current_user.manageable_users
  end

  def edit
    @turbo = params[:turbo].presence || true
  end

  def generate_reset_password_token
    @raw_token = @user.generate_reset_password_token

    # Send the reset email (but ensure it doesn't reset the token again)
    Devise.mailer.reset_password_instructions(@user, @raw_token).deliver_now
    render partial: "admin/users/password_management"
  end

  def create
    password = SecureRandom.hex(8)
    @user = User.new(user_params.merge(password: password))
    if @user.save
      respond_to do |format|
        format.html { redirect_to admin_user_path(@user), notice: "User created!" }
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("users", partial: "admin/users/user", locals: { user: @user }) + turbo_stream.update("new_user", "")
        end
      end
    else
      render :new
    end
  end

  def new
    @user = User.new
    @turbo = params[:turbo].presence || true
  end

  def show
    redirect_to user_profile_path(@user) if current_user == @user
  end
  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to admin_user_path(@user), notice: "User updated" }
        format.turbo_stream do
          render turbo_stream: update_view_and_tables
        end
      end
    else
      render :edit
    end
  end

  def destroy
    @user.update hidden: true
    redirect_to admin_users_path, notice: "User deleted"
  end


  private

  def update_view_and_tables
    turbo_stream.replace(dom_id(@user), partial: "admin/users/user", locals: { user: @user }) +
    turbo_stream.update("edit_user", "")
  end

  def authorize_admin
    return unless !current_user.management?
    redirect_to root_path, alert: "Admins only feature!"
  end

  def set_user
    @user = User.find(params[:id])
    consent_management
  end

  def consent_management
    return unless !@user.manageable?(current_user)

    redirect_to root_path, alert: "You can't manage this user"
  end

  def user_params
    params.require(:user).permit(:full_name, :phone, :birth_date, :salary, :shift_start, :shift_end, :avatar, :role, :email)
  end
end
