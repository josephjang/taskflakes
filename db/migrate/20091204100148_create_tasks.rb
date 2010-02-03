class CreateTasks < ActiveRecord::Migration
	def self.up
		create_table :tasks do |t|
			t.string	:title, :null => false
			t.text		:description
			t.string	:owner
			t.string	:project
			t.date		:start_date
			t.date		:finish_date
			t.date		:estimated_start_date
			t.date		:estimated_finish_date
			t.integer	:duration
			t.integer	:estimated_duration
			t.timestamps
		end
	end

	def self.down
		drop_table :tasks
	end
end
