class CreateTasks < ActiveRecord::Migration
	def self.up
		create_table :tasks do |t|
			t.string	:title, :null => false
			t.text		:description
			t.date		:start_date
			t.date		:finish_date
			t.timestamps
		end
	end

	def self.down
		drop_table :tasks
	end
end
