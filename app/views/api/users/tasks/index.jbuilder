json.data @tasks, partial: 'api/tasks/task', as: :task
json.links do
  json.first me_tasks_api_users_path(page: 1)
  json.last me_tasks_api_users_path(page: @tasks.total_pages)
  if !@tasks.first_page? && @tasks.total_pages != 0
    json.prev me_tasks_api_users_path(page: @tasks.prev_page)
  end
  if !@tasks.last_page? && @tasks.total_pages != 0
    json.next me_tasks_api_users_path(page: @tasks.next_page)
  end
end
