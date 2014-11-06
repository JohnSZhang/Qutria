json.count @notification_count
json.notifications @notifications do |notification|
  json.id notification.id
  json.new_type notification.new_object_type
  json.new_id notification.new_object_id
  json.your_type notification.notified_on_type
  json.your_id notification.notified_on_id
  json.read notification.read
  if notification.notified_on_type == "Question"
    json.q_id notification.notified_on_id
  else
    json.q_id Answer.find(notification.notified_on_id).question.id
  end
end
