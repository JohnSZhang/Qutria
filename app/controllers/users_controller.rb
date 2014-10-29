class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.includes(:favorite_tags).find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:msg] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    unless @user == current_user
      flash[:msg] = "Thats not you!"
      redirect_to root_url
    else
      @user = User.find(params[:id])
      render :edit
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      flash[:msg] = "Thats not you!"
      redirect_to root_url
    elsif @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:msg] = @user.errors_full_messages
      redirect_to user_url(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != current_user
      flash[:msg] = "Thats not you!"
      redirect_to root_url
    elsif @user.destroy
      redirect_to users_url
    else
      flash[:msg] = @user.errors_full_messages
      redirect_to user_url(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email, :name)
  end
end
