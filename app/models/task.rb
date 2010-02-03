class Task < ActiveRecord::Base

	belongs_to :project

	validates_presence_of :title
	validates_numericality_of :duration, :allow_nil => true, :greater_than => 0, :only_integer => true
	validates_numericality_of :estimated_duration, :allow_nil => true, :greater_than => 0, :only_integer => true
end
