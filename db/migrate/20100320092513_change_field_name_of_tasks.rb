class ChangeFieldNameOfTasks < ActiveRecord::Migration
  def self.up
	  rename_column :tasks, :project, :project_name
	  rename_column :tasks, :category, :category_name
  end

  def self.down
	  rename_column :tasks, :project_name, :project
	  rename_column :tasks, :category_name, :category
  end
end
