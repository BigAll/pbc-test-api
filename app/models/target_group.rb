class TargetGroup < ActiveRecord::Base
  has_closure_tree

  has_many :country_target_groups
  has_many :countries, through: :country_target_groups
  belongs_to :panel_provider

end
