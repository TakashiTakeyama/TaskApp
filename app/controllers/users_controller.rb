class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :only_current_user, only: %i[show edit]

  # def index
  #   @users = User.find(current_user.id).blogs
  #   # binding.pry
  # end

  def index
    @q = Blog.ransack(params[:q])
    # binding.pry
    if params[:q].present?
      @users = @q.result(distinct: true).page(params[:page]).per(7)
      # binding.pry
    elsif params[:expired_at].present?
      @users = User.find(current_user.id).blogs.page(params[:page]).per(7).order(expired_at: :DESC)
    elsif params[:priority].present?
      @users = User.find(current_user.id).blogs.page(params[:page]).per(7).order(priority: :DESC)
    else
      @users = User.find(current_user.id).blogs.page(params[:page]).per(7)
      # binding.pry
    end
    # binding.pry
  end

  def new
    if current_user.present?
      redirect_to user_path(User.find_by(id: session[:user_id])), notice: "その行為はできません。"
    end
    @user = User.new
  end

  def show
    if current_user.id == @user.id
    else
      redirect_to new_user_path, notice: "その行為は禁止されています。"
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    binding.irb
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to user_path, notice: "削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def only_current_user
    if current_user.present?
    else
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end
end
