json.array! @likes do |like|
  json.id like.id
  json.user_id like.user_id
  json.tutorial_id like.tutorial_id
  json.completed like.completed
end