class QuestionsController < ApplicationController

  def index
      @questions = Question.all
      render :index
    end

    def show
      @question = Question.find(params[:id])
      render :show
    end

    def new
      @question = Question.new
      render :new
    end

    def create
      @question = Question.new(question_params)
      @question.user = current_user
      if @question.save
        redirect_to question_url(@question)
      else
        flash[:msg] = @question.errors.full_message
        render :new
      end
    end

    def edit
      @question = Question.find(params[:id])
      render :edit
    end

    def update
      @question = Question.find(params[:id])
      if @question.update(question_params)
        redirect_to question_url(@question)
      else
        flash[:msg] = @question.errors_full_message
        redirect_to question_url(@question)
      end
    end

    def destroy
      @quesiton = Question.find(params[:id])
      if @quesiton.destroy
        redirect_to questions_url
      else
        flash[:msg] = @question.errors_full_message
        redirect_to question_url(@question)
      end
    end

    private
    def question_params
      params.require(:question).permit(:title, :body)
    end
end
