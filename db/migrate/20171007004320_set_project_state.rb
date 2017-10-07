class SetProjectState < ActiveRecord::Migration[5.1]
  class Project < ApplicationRecord
  end

  def up
    Project.where.not(finished_at: nil).update_all state: 'finished'
    Project.where(finished_at: nil).where.not(paused_at: nil).update_all state: 'paused'
    Project.where(finished_at: nil, paused_at: nil).where.not(started_at: nil).update_all state: 'started'
  end
end
