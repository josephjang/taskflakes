class Project < ActiveRecord::Base
	has_many :tasks

	validates_presence_of :name

    validates_date :start_date, :on_or_before => :end_date, :allow_blank => true
    validates_date :end_date, :on_or_after => :start_date, :allow_blank => true
    validates_date :estimated_start_date, :on_or_before => :estimated_finish_date, :allow_blank => true
    validates_date :estimated_finish_date, :on_or_after=> :estimated_start_date, :allow_blank => true
    validates_date :creation_date

    default_value_for :creation_date do
        Date.today
    end

end
