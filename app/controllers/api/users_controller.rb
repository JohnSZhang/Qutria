class Api::UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]

  def index
    #@users = User.all
    current_page = params[:page] || 1
    @users = User.page(current_page)
    @total_pages = @users.total_pages
    render template: "api/users"
  end

  def show
    @user = User.find(params[:id])
    if @user
      render template: "api/user"
    else
      render json: "{ 'error': 'Not A Valid User'}"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render template: "api/user"
    else
      render json: "{ 'error': '#{@user.errors.full_messages}'}",
          status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      render text: "that is not you!"
    elsif @user.update(user_params)
      render template: "api/user"
    else
      render text: "@user.errors.full_messages", status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != current_user
        render json: "{ 'error': '#{@user.errors.full_messages}'}",
        status: :unprocessable_entity
    elsif @user.destroy
      render template: "api/user"
    else
      render json: "{ 'error': '#{@user.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  def search
    current_page = params[:page] || 1
    @users = User.search_by_name(params[:query]).page(current_page)
    if @users
       render template: "api/users"
    else
      render text: "no result"
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :username, :password, :email, :name, :filepicker_url)
  end
end
