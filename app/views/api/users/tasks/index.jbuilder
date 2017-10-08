json.data @tasks, partial: 'api/tasks/task', as: :task
json.links do
  json.first me_tasks_api_users_path(page: 1)
  json.last me_tasks_api_users_path(page: @tasks.total_pages)
  unless @tasks.first_page?
    json.prev me_tasks_api_users_path(page: @tasks.prev_page)
  end
  unless @tasks.last_page?
    json.next me_tasks_api_users_path(page: @tasks.next_page)
  end
end
