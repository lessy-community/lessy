json.extract! project, :id, :name, :user_id, :description
json.task_ids project.tasks.not_abandoned.pluck(:id)
json.started_at project.started_at.to_i
json.due_at project.due_at.to_i
json.stopped_at project.paused_at.to_i
json.finished_at project.finished_at.to_i
json.is_in_progress project.started?
