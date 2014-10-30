class Api::CommentsController < Api::ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render template: "api/comment"
    else
      render json: "{ 'error': '#{@comment.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if not_owner?(@comment)
      render json: "{ 'error': 'Thats not your comment!'}",
        status: :unprocessable_entity
    elsif @comment.update(comment_params)
      render template: "api/comment"
    else
      render json: "{ 'error': '#{@comment.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if not_owner?(@comment)
      render json: "{ 'error': 'Thats not your answer!'}",
        status: :unprocessable_entity
    elsif @comment.destroy
      render template: "api/comment"
    else
      render json: "{ 'error': '#{@comment.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

end
