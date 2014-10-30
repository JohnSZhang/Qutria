class Api::AnswersController < Api::ApplicationController
  before_action :require_login

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      render template: "api/answer"
    else
      render json: "{ 'error': '#{@answer.errors.full_messages}'}",
        status: :unprocessable_entity
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if not_owner?(@answer)
      render json: "{ 'error': 'Thats not your answer!'}",
        status: :unprocessable_entity
    elsif
      @answer.update(answer_params)
      render template: "api/answer"
    else
      render json: "{ 'error': '#{@answer.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if not_owner?(@answer)
      render json: "{ 'error': 'Thats not your answer!'}",
        status: :unprocessable_entity
    elsif
      @answer.destroy
      render template: "api/answer"
    else
      render json: "{ 'error': '#{@answer.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
