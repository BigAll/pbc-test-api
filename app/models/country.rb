class Country < ActiveRecord::Base

  has_many :location_groups
  has_many :country_target_groups
  has_many :target_groups, through: :country_target_groups
  belongs_to :panel_provider

  validates_with TargetGroupsValidator
end
