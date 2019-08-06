class LabelingsController < ApplicationController
  def create
    current_user.labelings.create(blog_id: params[:blog_id])
    redirect_to blogs_url
  end

  def destroy
    current_user.labelings.find_by(id: params[:id]).destroy
    redirect_to blogs_url
  end
end
