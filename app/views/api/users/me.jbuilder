json.user @user, partial: 'api/users/user', as: :user
json.projects @projects, partial: 'api/projects/project', as: :project
json.number_finished_projects @number_finished_projects
