json.data do
  json.id @user.id
  json.type 'user'
  json.attributes do
    json.extract! @user, :username, :email, :time_zone
  end
end
