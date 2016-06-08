class Location < ActiveRecord::Base

	validates :postal_code, presence: true
	
	belongs_to :user

	geocoded_by :postal_code
	after_validation :geocode, :if => :postal_code_changed?


end
