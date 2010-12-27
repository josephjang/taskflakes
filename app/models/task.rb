class Task < ActiveRecord::Base

	belongs_to :category
	belongs_to :project
	belongs_to :status
	belongs_to :owner, :class_name => 'User'
	belongs_to :organization

	validates_presence_of :title
	validates_numericality_of :duration, :allow_nil => true, :greater_than_or_equal_to => 0, :only_integer => false
	validates_numericality_of :estimated_duration, :allow_nil => true, :greater_than => 0, :only_integer => false

    validates_date :start_date, :on_or_before => :finish_date, :allow_blank => true
    validates_date :finish_date, :on_or_after => :start_date, :allow_blank => true
    validates_date :estimated_start_date, :on_or_before => :estimated_finish_date, :allow_blank => true
    validates_date :estimated_finish_date, :on_or_after=> :estimated_start_date, :allow_blank => true

    # custom validation
    def validate

        if status_id == 2 and (estimated_start_date.nil? and estimated_finish_date.nil?) then
            errors.add(:estimated_start_date, "can't be blank if status is 'Scheduled'")
            errors.add(:estimated_finish_date, "can't be blank if status is 'Scheduled'")
        end

        if status_id == 2 and !start_date.nil? then
            errors.add(:start_date, "should be blank if status is 'Scheduled'")
        end

        if status_id == 2 and !finish_date.nil? then
            errors.add(:finish_date, "should be blank if status is 'Scheduled'")
        end

        if status_id == 3 and start_date.nil? then
            errors.add(:start_date, "can't be blank if status is 'Ongoing'")
        end

        if status_id == 3 and !finish_date.nil? then
            errors.add(:finish_date, "should be blank if status is 'Ongoing'")
        end

        if status_id == 4 and finish_date.nil? then
            errors.add(:finish_date, "can't be blank if status is 'Completed'")
        end
    end

    # filter by status & dates
    named_scope :twoweek, :conditions => [ "status_id = 3 OR (status_id = 4 AND finish_date >= ?) OR (status_id = 2 AND estimated_start_date <= ?)", 7.days.ago, 7.days.from_now ]
    named_scope :last_week, :conditions => [ "status_id = 3 OR (status_id = 4 AND finish_date >= ?)", 7.days.ago ]
    named_scope :next_week, :conditions => [ "status_id = 3 OR (status_id = 2 AND estimated_start_date <= ?)", 7.days.from_now ]

    # filter by status
    named_scope :scheduled, :conditions => [ "status_id = 2" ]
    named_scope :ongoing, :conditions => [ "status_id = 3" ]
    named_scope :done, :conditions => [ "status_id = 4" ]
    named_scope :undetermined, :conditions => [ "status_id = 1" ]
    named_scope :scheduled_or_ongoing, :conditions => [ "status_id = 2 or status_id = 3" ]
    named_scope :ongoing_or_done, :conditions => [ "status_id = 3 or status_id = 4" ]

    # filter by dates
    named_scope :recently_scheduled, :conditions => [ "estimated_start_date < ?", 7.days.from_now]
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
    named_scope :per_project, :order => "category_id, project_id, project_name, start_date, finish_date, estimated_start_date, estimated_finish_date, title"
    named_scope :per_owner, :order => "owner_id, category_id, project_id, project_name, start_date, finish_date, estimated_start_date, estimated_finish_date, title"

end
