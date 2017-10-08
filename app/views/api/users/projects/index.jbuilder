json.data @projects, partial: 'api/projects/project', as: :project
json.links do
  json.first me_projects_api_users_path(page: 1)
  json.last me_projects_api_users_path(page: @projects.total_pages)
  unless @projects.first_page?
    json.prev me_projects_api_users_path(page: @projects.prev_page)
  end
  unless @projects.last_page?
    json.next me_projects_api_users_path(page: @projects.next_page)
  end
end
