class ChangeDurationColumnIntoFloatType < ActiveRecord::Migration
  def self.up
      change_column :tasks, :duration, :float
      change_column :tasks, :estimated_duration, :float
  end

  def self.down
      change_column :tasks, :duration, :integer
      change_column :tasks, :estimated_duration, :integer
  end
end
