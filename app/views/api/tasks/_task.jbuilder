json.extract! task, :id, :label, :order, :user_id, :planned_count, :project_id, :project_name
json.created_at task.started_at.to_i
json.planned_at task.planned_at.to_i
json.finished_at task.finished_at.to_i
json.abandoned_at task.abandoned_at.to_i
