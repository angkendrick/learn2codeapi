json.username @user.username
json.first_name @user.first_name
json.last_name @user.last_name
json.email @user.email
json.avatar @user.avatar

json.likes do
  json.array! @user.likes do |like|
    json.tutorial_id like.tutorial.id
    json.tutorial_name like.tutorial.name
    json.tutorial_url like.tutorial.url
    json.like_completed like.completed
    json.like_created_at like.created_at
    json.subject do
      json.array! like.tutorial.subjects do |subject|
        json.subject_id subject.id
        json.subject_name subject.name
      end
    end
  end
end

json.reviews do
  json.array! @user.reviews do |review|
    json.review_tutorial_id  review.tutorial_id
    json.review_rating  review.rating
    json.review_description review.description
    json.tutorial_name review.tutorial.name
    json.tutorial_description review.tutorial.description
    json.tutorial_url review.tutorial.url
    json.tutorial_image review.tutorial.tutorialimage
    json.tutorial_company review.tutorial.company
    json.subject do
      json.array! review.tutorial.subjects do |subject|
        json.subject_id subject.id
        json.subject_name subject.name
      end
    end
  end
end

json.tutorials do
  json.array! @tutorials do |tutorial|
    json.tutorial_id tutorial.id
    json.tutorial_url tutorial.url
    json.tutorial_image tutorial.tutorialimage
    json.tutorial_name tutorial.name
  end
end
