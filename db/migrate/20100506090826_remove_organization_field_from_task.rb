class RemoveOrganizationFieldFromTask < ActiveRecord::Migration
  def self.up
	  remove_column :tasks, :organization
  end

  def self.down
	  add_column :tasks, :organization
  end
end
