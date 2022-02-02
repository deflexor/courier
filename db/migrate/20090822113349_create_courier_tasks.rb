class CreateCourierTasks < ActiveRecord::Migration
  def self.up
    create_table :courier_tasks do |t|
      t.string :manager, :limit =>  32, :null => false
      t.text :line_expences
      t.string :status, :limit => 16, :null => false
      t.text :bills
      t.text :client_org
      t.text :client_person
      t.string :client_phone, :limit =>  32
      t.text :client_address
      t.text :description
      t.text :priority

      t.datetime :created_at
      t.datetime :approved_at
      t.datetime :completed_at
      t.datetime :finished_at
    end
    add_index :courier_tasks, :manager
  end

  def self.down
    drop_table :courier_tasks
  end
end
