class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.date :estimated_start_date
      t.date :estimated_finish_date
      t.date :creation_date

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
