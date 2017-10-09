json.data @projects, partial: 'api/projects/project', as: :project
json.links do
  json.first me_projects_api_users_path(page: 1)
  json.last me_projects_api_users_path(page: @projects.total_pages)
  if !@projects.first_page? && @projects.total_pages != 0
    json.prev me_projects_api_users_path(page: @projects.prev_page)
  end
  if !@projects.last_page? && @projects.total_pages != 0
    json.next me_projects_api_users_path(page: @projects.next_page)
  end
end
