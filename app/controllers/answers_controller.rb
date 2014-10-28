class AnswersController < ApplicationController
  def edit
    @answer = Answer.find(params[:id])
    render :edit
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if @answer.update(params[:answer[:question_id]])
      redirect_to question_url(@question)
    else
      flash[:msg] = @answer.errors_full_message
      render :edit
    end
  end

  def create
    @answer = Answer.new(params[:answer[:body]])
    @question = Question.get(params[:answer[:question_id]])
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      redirect_to question_url(@question)
    else
      flash[:msg] = @answer.errors.full_message
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to root_url
    else
      flash[:msg] = @answer.errors_full_message
      redirect_to question_url(@answer.question)
    end
  end

end
