class CreateLocationLocationGroups < ActiveRecord::Migration
  def change
    create_table :location_location_groups do |t|
      t.integer :location_id
      t.integer :location_group_id

      t.timestamps null: false
    end
  end
end
