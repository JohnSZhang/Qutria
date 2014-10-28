class AnswersController < ApplicationController
  def edit
    @answer = Answer.find(params[:id])
    render :edit
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if @answer.update(answer_params)
      redirect_to question_url(@question)
    else
      flash[:msg] = @answer.errors_full_message
      render :edit
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_url(@answer.question)
    else
      flash[:msg] = @answer.errors.full_message
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to question_url(@answer.question)
    else
      flash[:msg] = @answer.errors_full_message
      redirect_to question_url(@answer.question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
