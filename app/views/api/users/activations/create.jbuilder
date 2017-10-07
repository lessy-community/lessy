json.data @user, partial: 'api/users/user', as: :user
json.meta do
  json.token @token
end
