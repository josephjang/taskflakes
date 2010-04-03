class Task < ActiveRecord::Base

	belongs_to :project

	validates_presence_of :title
	validates_numericality_of :duration, :allow_nil => true, :greater_than => 0, :only_integer => true
	validates_numericality_of :estimated_duration, :allow_nil => true, :greater_than => 0, :only_integer => true

    # filter by status
    named_scope :scheduled, :conditions => [ "status = '예정'" ]
    named_scope :ongoing, :conditions => [ "status = '진행중'" ]
    named_scope :done, :conditions => [ "status = '완료'" ]

    # filter by dates
    named_scope :recently_scheduled, :conditions => [ "estimated_start_date < ? AND estimated_finish_date >= ?", 7.days.from_now, 7.days.ago ]
    named_scope :recently_done, :conditions => [ "finish_date >= ?", 7.days.ago ]

    # filter by owner
    named_scope :owned_by, lambda { |owner|
        { :conditions => ["owner = ?", owner] }
    }

    # ordering
    named_scope :per_project, :order => "category_name, project_name, start_date, finish_date, estimated_start_date, estimated_finish_date, title"

end
