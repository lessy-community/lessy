json.extract! project, :id, :name, :user_id, :description
json.started_at project.started_at.to_i
json.due_at project.due_at.to_i
json.stopped_at project.stopped_at.to_i
json.finished_at project.finished_at.to_i
json.is_in_progress project.in_progress?
