class PanelProvider < ActiveRecord::Base
  self.inheritance_column = 'code'

  def price
  #   implemented in specific panel proivider implementations
  end
end
