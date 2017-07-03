class Location < ActiveRecord::Base
  has_many :location_location_groups
  has_many :location_groups, through: :location_location_groups
end
