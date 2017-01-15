json.extract! project, :id, :name, :user_id, :description
json.started_at project.started_at.to_i
json.due_at project.due_at.to_i
