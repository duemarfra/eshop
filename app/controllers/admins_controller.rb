class AdminsController < ApplicationController
  before_action :authorize!

  def index
    @users = User.all.order(username: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    user
  end

  def update
    if user.update(user_params)
      redirect_to admins_path, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy

    redirect_to admins_path, notice: t(".destroyed")
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :admin, :business, :customer)
  end
end
