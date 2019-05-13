json.type 'project'
json.id project.id
json.attributes do
  json.extract! project, :name, :slug, :description, :state,
                :started_at, :due_at, :paused_at, :finished_at,
                :created_at, :updated_at
end
json.relationships do
  json.user do
    json.data do
      json.type 'user'
      json.id project.user_id
    end
  end
  json.tasks do
    json.data project.tasks.not_abandoned do |task|
      json.type 'task'
      json.id task.id
    end
  end
end
