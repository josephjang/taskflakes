class RemoveStatusFieldFromTask < ActiveRecord::Migration
  def self.up
	  remove_column :tasks, :status
  end

  def self.down
	  add_column :tasks, :status, :string, :null => false
  end
end
