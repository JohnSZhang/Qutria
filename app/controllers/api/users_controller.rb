class Api::UsersController < ApplicationController
  def index
    render json: '{"hi": "hello!"}'
  end
end
