json.array! @impacted_tasks do |task|
  json.extract! task, :id, :order
end
