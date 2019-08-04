class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :only_adminuser, only: %i[index new edit destroy]

  def index
    @users = User.all.includes(:blogs)
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
      flash[:notice] = '削除しました'
    else
      redirect_to admin_users_path
      flash[:danger] = '管理者権限を持つユーザーを0人にすることは出来ません'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :administrator)
  end

  def only_adminuser
    begin
      redirect_to new_user_path if current_user.present? && current_user.administrator != true
    rescue => e
      logger.error e
    end
  end
end
