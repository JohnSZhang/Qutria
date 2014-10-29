class TagsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]

  def index
    @tags = Tag.all
    render :index
  end

  def show
    # @tag = Tag.includes(:questions, questions: :user).find(params[:id])
    @tag = Tag.find(params[:id])
    render :show
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tag_url(@tag)
    else
      flash[:msg] = @tag.errors.full_messages
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    render :edit
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tag_url(@tag)
    else
      flash[:msg] = @tag.errors_full_messages
      redirect_to tag_url(@tag)
    end
  end

  def destroy
    @quesiton = Tag.find(params[:id])
    if @quesiton.destroy
      redirect_to tags_url
    else
      flash[:msg] = @tag.errors_full_messages
      redirect_to tag_url(@tag)
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :description)
  end

end
