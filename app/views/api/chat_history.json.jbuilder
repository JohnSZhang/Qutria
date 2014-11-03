json.array! @chats do |chat|
  json.user chat.user.username
  json.message chat.message
end
