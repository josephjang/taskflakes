class RemoveCategoryNameFieldFromTask < ActiveRecord::Migration
  def self.up
      remove_column :tasks, :category_name
  end

  def self.down
	  add_column :tasks, :category_name, :string, :null => false
  end
end
