require 'pusher'

Pusher.app_id = ENV['PUSHER_APP']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']

class Api::ChatsController < Api::ApplicationController
  def get_chat
    Pusher.trigger(params[:channel], 'server-message', { message: params[:message]})
    render text: ""
  end
end
