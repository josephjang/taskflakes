class AddRelationFromTaskToUser < ActiveRecord::Migration
  def self.up
    add_column :tasks, :owner_id, :integer
  end

  def self.down
    remove_column :tasks, :owner_id, :integer
  end
end
