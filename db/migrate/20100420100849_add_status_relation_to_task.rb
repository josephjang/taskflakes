class AddStatusRelationToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :status_id, :integer
  end

  def self.down
    remove_column :tasks, :status_id
  end
end
