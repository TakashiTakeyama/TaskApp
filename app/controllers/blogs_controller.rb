class BlogsController < ApplicationController
  # before_action :basic
  before_action :set_blog, only: %i[show edit update destroy]

  def index
      @q = Blog.ransack(params[:q])
    if params[:q].present?
      @blogs = @q.result(distinct: true)
    elsif params[:expired_at].present?
      @blogs = Blog.all.order(expired_at: :DESC)
    else
      @blogs = Blog.all
    end
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render 'new'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
      redirect_to blogs_path, notice: "削除しました"
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:name, :details, :expired_at, :state)
  end

  def production?
    Rails.env.production?
  end

  def basic
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_NAME"] && password == ENV["BASIC_AUTH_PASSWORD"] if Rails.env == "production"
    end
  end
end


