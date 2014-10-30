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
    puts @favorite
    if @favorite && @favorite.destroy
      render template: "api/favorite"
    else
      render json: "{ 'error': 'cannot destroy'}",
      status: :unprocessable_entity
    end
  end

  # def show
  #   unless is_logged_in?
  #     redirect_to new_session_url
  #   else
  #     @user = User.includes(:favorite_tags, :favorite_tag_questions).find(current_user.id)
  #     render :show
  #   end
  # end

end
