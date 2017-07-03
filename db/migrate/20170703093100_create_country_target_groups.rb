class CreateCountryTargetGroups < ActiveRecord::Migration
  def change
    create_table :country_target_groups do |t|
      t.integer :country_id
      t.integer :target_group_id

      t.timestamps null: false
    end
  end
end
