json.user @user, partial: 'api/users/user', as: :user
json.projects @user.projects, partial: 'api/projects/project', as: :project
json.token @token
