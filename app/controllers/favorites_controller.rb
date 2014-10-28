class FavoritesController < ApplicationController
  def create
    tag = Tag.find(params[:tag_id])
    user = current_user
    @favorite = Favorite.new(
      user: user,
      tag: tag
    )
    if @favorite.save
      redirect_to tag_url(tag)
    else
      flash[:msg] = @favorite.errors.full_messages
      redirect_to tag_url(tag)
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
        redirect_to tag_url(tag)
    else
        flash[:msg] = @favorite.errors.full_messages
        redirect_to tag_url(tag)
    end
  end

  def show
    unless is_logged_in?
      redirect_to new_session_url
    else
      @user = User.includes(:favorite_tags, :favorite_tag_questions).find(current_user.id)
      render :show
    end
  end

end
