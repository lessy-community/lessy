json.data @impacted_tasks do |task|
  json.type 'task'
  json.id task.id
  json.attributes do
    json.order task.reload.order
  end
end
