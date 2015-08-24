json.id tutorial.id
json.name tutorial.name
json.description tutorial.description
json.url tutorial.url
json.tutorialimage tutorial.tutorialimage
json.cost tutorial.cost
json.difficulty tutorial.difficulty
json.format tutorial.format
json.company tutorial.company

json.subjects do
  json.array! tutorial.subjects do |subject|
      json.subject_id subject.id
      json.subject_name subject.name
      json.subject_description subject.description
  end
end
