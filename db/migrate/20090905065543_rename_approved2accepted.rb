class RenameApproved2accepted < ActiveRecord::Migration
  def self.up
    rename_column(:courier_tasks, :approved_at, :accepted_at)
  end

  def self.down
    rename_column(:courier_tasks, :accepted_at, :approved_at)
  end
end
