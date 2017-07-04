class Country < ActiveRecord::Base

  belongs_to :panel_provider
  has_many :location_groups
  has_many :locations, through: :location_groups
  has_many :current_locations, ->(obj) { where("location_groups.panel_provider_id = ?", obj.panel_provider_id)}, class_name: 'Location', through: :location_groups, source: :locations

  has_many :country_target_groups
  has_many :target_groups, through: :country_target_groups
  has_many :current_target_groups, ->(obj) { where(panel_provider_id: obj.panel_provider_id)}, class_name: 'TargetGroup', through: :country_target_groups, source: :target_group

  validates_uniqueness_of :country_code
  validates_with TargetGroupsValidator
end
