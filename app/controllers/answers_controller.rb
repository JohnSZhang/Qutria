class AnswersController < ApplicationController
  before_action :require_login

  def edit
    @answer = Answer.find(params[:id])
    if check_owner(@answer)
    else
      render :edit
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if check_owner(@answer)
    elsif
      @answer.update(answer_params)
      redirect_to question_url(@question)
    else
      flash[:msg] = @answer.errors_full_messages
      render :edit
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_url(@answer.question)
    else
      flash[:msg] = @answer.errors.full_messages
      redirect_to question_url(@answer.question)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if check_owner(@answer)
    elsif
      @answer.destroy
      redirect_to question_url(@answer.question)
    else
      flash[:msg] = @answer.errors_full_messages
      redirect_to question_url(@answer.question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
