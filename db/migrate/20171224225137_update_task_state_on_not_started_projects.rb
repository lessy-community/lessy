class UpdateTaskStateOnNotStartedProjects < ActiveRecord::Migration[5.1]
  def up
    Project.not_started.find_each do |project|
      project.tasks.started.update_all state: 'newed', started_at: nil
    end
  end

  def down
    Task.newed.update_all "state = 'started', started_at = created_at"
  end
end
