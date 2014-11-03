class Api::QuestionsController < Api::ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

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
        render template: "api/question"
    else
      render json: "{ 'error': 'Cannot Create question #{@question.errors.full_messages}'}",
        status: :unprocessable_entity
    end
  end

  def update
    @question = Question.find(params[:id])
    if not_owner?(@question)
      render json: "{ 'error': 'not your question!'}",
        status: :unprocessable_entity
    elsif
      @question.update(question_params)
      render template: "api/question"
    else
      render json: "{ 'error': '#{@question.errors.full_messages}'}",
        status: :unprocessable_entity
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if not_owner?(@question)
      render json: "{ 'error': 'not your question!'}",
        status: :unprocessable_entity
    elsif @question.destroy
      render template: "api/question"
    else
      render json: "{ 'error': '#{@question.errors.full_messages}'}",
        status: :unprocessable_entity
    end
  end

  def best_answer
    @question = Question.find(params[:id])
    @answer = Answer.find(params[:answer_id])
    if !@question || !@answer
      render json: "{ 'error': 'not a valid question or answer!'}",
        status: :unprocessable_entity
    elsif not_owner?(@question)
      render json: "{ 'error': 'not your question!'}",
        status: :unprocessable_entity
    elsif @question.best_answer?
      render json: "{ 'error': 'aleady has best answer!'}",
        status: :unprocessable_entity
    elsif @question.best_answer = @answer
      render json: { msg: 'updated!'}.to_json
    else
      render json: "{ 'error': 'cannot update best answer!'}",
        status: :unprocessable_entity
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
