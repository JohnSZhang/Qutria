json.array! @notifications do |notification|
  json.id notification.id
  json.new_type notification.new_object_type
  json.new_id notification.new_object_id
  json.your_type notification.notified_on_type
  json.your_id notification.notified_on_id
  json.read notification.read
end
