class CountryTargetGroup < ActiveRecord::Base
  belongs_to :country
  belongs_to :target_group
end
