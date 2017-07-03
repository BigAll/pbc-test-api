class LocationGroup < ActiveRecord::Base

  belongs_to :country
  has_many :location_location_groups
  has_many :locations, through: :location_location_groups
  belongs_to :panel_provider

end
