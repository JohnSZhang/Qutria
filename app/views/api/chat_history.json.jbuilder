json.array! @chats do |chat|
  json.user chat.user.username
  json.message chat.message
  json.filepicker_url chat.user.filepicker_url
end
