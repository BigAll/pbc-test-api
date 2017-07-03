class Country < ActiveRecord::Base

  has_many :location_groups
  has_many :country_target_groups
  has_many :target_groups, through: :country_target_groups
  belongs_to :panel_provider
  has_many :locations, through: :location_groups

  validates_uniqueness_of :country_code
  validates_with TargetGroupsValidator
end
