json.id user.id
json.type 'user'
json.attributes do
  json.extract! user, :username, :email, :admin
  json.has_accepted_tos user.accepted_tos?
end
