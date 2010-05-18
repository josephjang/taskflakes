class Task < ActiveRecord::Base

	belongs_to :category
	belongs_to :project
	belongs_to :status
	belongs_to :owner, :class_name => 'User'
	belongs_to :organization

	validates_presence_of :title
	validates_numericality_of :duration, :allow_nil => true, :greater_than_or_equal_to => 0, :only_integer => false
	validates_numericality_of :estimated_duration, :allow_nil => true, :greater_than => 0, :only_integer => false

    # filter by status
    named_scope :scheduled, :conditions => [ "status_id = 2" ]
    named_scope :ongoing, :conditions => [ "status_id = 3" ]
    named_scope :done, :conditions => [ "status_id = 4" ]

    # filter by dates
    named_scope :recently_scheduled, :conditions => [ "estimated_start_date < ? AND estimated_finish_date >= ?", 7.days.from_now, 7.days.ago ]
    named_scope :recently_done, :conditions => [ "finish_date >= ?", 7.days.ago ]

    # filter by owner
    named_scope :owned_by, lambda { |owner|
        { :conditions => ["owner_id = ?", owner] }
    }

    # filter by organization
    named_scope :belong_to_organization, lambda { |organization|
        { :conditions => ["organization_id = ?", organization ] }
    }

    # filter by project
    named_scope :belong_to_project, lambda { |project|
        { :conditions => ["project_name = ?", project] }
    }


    # ordering
    named_scope :per_project, :order => "category_id, project_name, start_date, finish_date, estimated_start_date, estimated_finish_date, title"

end
