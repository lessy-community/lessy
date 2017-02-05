json.array! @tasks do |task|
  json.partial! 'api/tasks/task', task: task
end
