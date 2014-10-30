class Api::TagsController < Api::ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]

  def index
    @tags = Tag.all
    render template: "api/tags"
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render template: "api/tag"
    else
      render json: "{ 'error': '#{@tag.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end
  def show
    # @tag = Tag.includes(:questions, questions: :user).find(params[:id])

    @tag = Tag.find(params[:id])
    if @tag
      render template: "api/tag"
    else
      render json: "{ 'error': 'That tag does not exist'",
      status: :not_found
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      render template: "api/tag"
    else
      render json: "{ 'error': '#{@tag.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :description)
  end

end
