class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :courier_task
      t.string :author, :limit => 32, :null => false
      t.text :body, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
