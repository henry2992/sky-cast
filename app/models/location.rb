class Location < ActiveRecord::Base


	geocoded_by :postal_code
	after_validation :geocode, :if => :postal_code_changed?


end
