class Api::QuestionsController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update, :destroy]

  def index
    @questions = Question.all
    render template: "api/questions"
  end

  def show
    @question = Question.includes(:user,
    :tags,
    :comments,
    answers: :user,
    comments: :user,
    answers: :comments,
    answers: { comments: :user }).find(params[:id])
    render template: "api/question"
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to question_url(@question)
    else
      flash[:msg] = @question.errors.full_messages
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    if check_owner(@question)
    elsif
      @question.update(question_params)
      redirect_to question_url(@question)
    else
      flash[:msg] = @question.errors_full_messages
      redirect_to question_url(@question)
    end
  end

  def destroy
    @quesiton = Question.find(params[:id])
    if check_owner(@question)
    elsif
      @quesiton.destroy
      redirect_to questions_url
    else
      flash[:msg] = @question.errors_full_messages
      redirect_to question_url(@question)
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
