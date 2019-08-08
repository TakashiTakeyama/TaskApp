class BlogsController < ApplicationController
  # before_action :basic
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :only_current_user, only: %i[index show new edit]
  PER = 8

  def index
    if current_user.present?
        @q = current_user.blogs.ransack(params[:q])
      if params[:q].present? && current_user.present?
        @blogs = @q.result(distinct: true).page(params[:page]).per(7)
      elsif params[:expired_at].present?
        @blogs = current_user.blogs.page(params[:page]).per(7).order(expired_at: :DESC)
      elsif params[:priority].present?
        @blogs = current_user.blogs.page(params[:page]).per(7).order(priority: :DESC)
      else
        @blogs = current_user.blogs.page(params[:page]).per(7)
      end
    else
        @q = Blog.ransack(params[:q])
      if params[:q].present?
        @blogs = @q.result(distinct: true).page(params[:page]).per(7)
      elsif params[:expired_at].present?
        @blogs = Blog.page(params[:page]).per(7).order(expired_at: :DESC)
      elsif params[:priority].present?
        @blogs = Blog.page(params[:page]).per(7).order(priority: :DESC)
      else
        @blogs = Blog.page(params[:page]).per(7)
      end
    end
  end

  def show
  end

  def new
    @blog = Blog.new
    @blog.labelings.build
    # binding.pry
  end

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render 'new'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
      redirect_to users_path
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:name, :details, :expired_at, :state, :priority, label_ids:[])
                                 # labels_attributes: [
                                 #   :id,
                                 #   :label_name,
                                 #   :_destroy,
                                 #   label_ids: []
                                 # ]
    # )
  end

  def production?
    Rails.env.production?
  end

  def basic
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_NAME"] && password == ENV["BASIC_AUTH_PASSWORD"] if Rails.env == "production"
    end
  end

  def only_current_user
    if current_user.present?
    else
      redirect_to new_session_path
    end
  end
end


