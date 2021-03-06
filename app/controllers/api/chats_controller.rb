require 'pusher'

Pusher.app_id = ENV['PUSHER_APP']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']

class Api::ChatsController < Api::ApplicationController
  def set_main_chat
    Pusher.trigger("main", 'server-message', { message: params[:message]})
    render text: ""
  end

  def set_chat_channel
    tag = Tag.find_by_name(params[:name])
    render json: "{ 'error': 'invalid chatroom'}",
      status: :unprocessable_entity unless tag
    render json: "{ 'error': 'you need to log in to use tag chats'}",
      status: :unprocessable_entity unless current_user
    chat_data = { user: current_user, message: params[:message]}
    Pusher.trigger(params[:name], 'server-message', chat_data.to_json)
    Chat.create(user: current_user, tag: tag, message: params[:message])
    render text: ""
  end

  def get_history
    @chats = Tag.find_by_name(params[:name]).chats.limit(10)
    render template: "api/chat_history"
  end
end
