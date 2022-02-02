class AddSomeCourierTaskColumns < ActiveRecord::Migration
  def self.up
    add_column :courier_tasks, :placement, :text
    add_column :courier_tasks, :deal_info, :text
  end

  def self.down
    remove_column(:courier_tasks, [:placement, :deal_info])
  end
end
