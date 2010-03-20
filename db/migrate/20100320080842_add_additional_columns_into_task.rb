class AddAdditionalColumnsIntoTask < ActiveRecord::Migration
  def self.up
	  add_column :tasks, :category, :string, :null => false
	  add_column :tasks, :category_id, :integer, :null => true
	  add_column :tasks, :status, :string, :null => false
	  add_column :tasks, :organization, :string, :null => true
  end

  def self.down
	  remove_column :tasks, :category
	  remove_column :tasks, :category_id
	  remove_column :tasks, :status
	  remove_column :tasks, :organization
  end
end
