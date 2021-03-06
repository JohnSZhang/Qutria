class Api::TagsController < Api::ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]

  def index
    #@tags = Tag.all
    current_page = params[:page] || 1
    @tags = Tag.page(current_page)
    @total_pages = @tags.total_pages
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
    if is_logged_in? && @tag
      @favorite = Favorite.find_by(
          user: current_user,
          tag: @tag
      )
    end
    if @tag
      render template: "api/tag"
    else
      render json: "{ 'error': 'That tag does not exist'",
      status: :not_found
    end
  end

  def search_chat
    @tags = Tag.search_by_name(params[:query]).limit(6)
    if @tags
       render template: "api/tags"
    else
      render text: "no result"
    end
  end

  def search
    current_page = params[:page] || 1
    @tags = Tag.search_by_name(params[:query]).page(current_page)
    if @tags
       render template: "api/tags"
    else
      render text: "no result"
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
