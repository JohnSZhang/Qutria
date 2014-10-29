class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to request.referrer
    else
      flash[:msg] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    if check_owner(@comment)
    else
      render :edit
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if check_owner(@comment)
    elsif
      @comment.update(comment_params)
      redirect_to root_url
    else
      flash[:msg] = @comment.errors.full_messages
      redirect_to root_url
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    if check_owner(@comment)
    elsif @comment.destroy
      redirect_to root_url
    else
      flash[:msg] = @comment.errors.full_messages
      redirect_to root_url
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end

end
