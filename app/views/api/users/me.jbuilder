json.user @user, partial: 'api/users/user', as: :user
json.tasks @tasks, partial: 'api/tasks/task', as: :task
json.projects @projects, partial: 'api/projects/project', as: :project
json.number_finished_projects @number_finished_projects
