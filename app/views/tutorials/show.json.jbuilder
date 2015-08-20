json.id @tutorial.id
json.name @tutorial.name
json.description @tutorial.description
json.url @tutorial.url
json.tutorialimage @tutorial.tutorialimage
json.cost @tutorial.cost
json.difficulty @tutorial.difficulty
json.format @tutorial.format
json.company @tutorial.company

json.user do
  json.first_name @tutorial.user.first_name
  json.last_name @tutorial.user.last_name
  json.username @tutorial.user.username
  json.email @tutorial.user.email
  json.avatar @tutorial.user.avatar
end

json.reviews do
  @tutorial.reviews.each do |review|
    json.rating review.rating
    json.description review.description
    json.username review.user.username
    json.first_name review.user.first_name
    json.last_name review.user.last_name
  end
end

