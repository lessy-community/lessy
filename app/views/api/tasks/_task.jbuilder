json.type 'task'
json.id task.id
json.attributes do
  json.extract! task, :label, :order, :planned_count, :state,
                :started_at, :planned_at, :finished_at, :abandoned_at,
                :created_at, :updated_at
end
json.relationships do
  json.user do
    json.data do
      json.type 'user'
      json.id task.user_id
    end
  end
  json.project do
    json.data do
      if task.project.nil?
        json.nil!
      else
        json.type 'project'
        json.id task.project_id
      end
    end
  end
end
