json.data @user, partial: 'api/users/user', as: :user
if @token
  json.meta do
    json.token @token
  end
end
