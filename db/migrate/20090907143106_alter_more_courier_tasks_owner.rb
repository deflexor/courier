class AlterMoreCourierTasksOwner < ActiveRecord::Migration
  def self.up
    change_table :courier_tasks do |t|
      t.remove :manager
      t.integer :manager_id, :null => false
      t.integer :courier_id

    end
  end

  def self.down
    change_table :courier_tasks do |t|
      t.string :manager, :limit => 40, :null => false
      t.remove :manager_id, :courier_id
    end
  end
end
