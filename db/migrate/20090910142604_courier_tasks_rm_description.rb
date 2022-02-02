class CourierTasksRmDescription < ActiveRecord::Migration
  def self.up
    # add subject and remove description
    remove_column(:courier_tasks, [:description])
    add_column :courier_tasks, :subject, :text
  end

  def self.down
    add_column :courier_tasks, :description, :text
    remove_column(:courier_tasks, [:subject])
  end
end
