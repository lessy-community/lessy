json.data do
  json.id @user.id
  json.type 'user'
  json.attributes do
    json.has_accepted_tos @user.accepted_tos?
  end
end
