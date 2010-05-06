class RemoveOwnerFieldFromTask < ActiveRecord::Migration
  def self.up
	  remove_column :tasks, :owner
  end

  def self.down
	  add_column :tasks, :owner
  end
end
