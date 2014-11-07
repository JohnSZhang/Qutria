class Api::FavoritesController < Api::ApplicationController
  before_action :require_login

  def create
    tag = Tag.find(params[:tag_id])
    user = current_user
    @favorite = Favorite.new(
      user: user,
      tag: tag
    )
    if @favorite.save
      render template: "api/favorite"
    else
      render json: "{ 'error': '#{@favorite.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end


  def destroy
    tag = params[:tag_id]
    user = current_user
    @favorite = Favorite.find_by(
      user: user,
      tag: tag
    )
    if @favorite && @favorite.destroy
      render template: "api/favorite"
    else
      render json: "{ 'error': 'cannot destroy'}",
      status: :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:favorite_tags, :favorite_tag_questions).find(current_user.id)
    current_page = params[:page] || 1
    puts params[:page]
    @questions = @user.favorite_tag_questions.page(current_page)
    render template: "api/user_favorites"
  end

end
