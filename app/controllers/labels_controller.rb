class LabelsController < ApplicationController
  before_action :set_label, only: %i[show edit update destroy]
  def index
    @labels = Label.all
  end

  def show
  end

  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = Label.new(label_params)
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path
    else
      render 'new'
    end
  end

  def update
    if @label.update
      redirect_to labels_path
    else
      render 'edit'
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:label_name)
  end
end
