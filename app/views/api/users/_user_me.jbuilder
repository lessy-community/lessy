json.user user, partial: 'api/users/user', as: :user
json.tasks user.tasks.due_on_today, partial: 'api/tasks/task', as: :task
json.projects user.projects.not_finished, partial: 'api/projects/project', as: :project
json.number_finished_projects user.projects.finished.count
