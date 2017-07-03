require 'rails_helper'

RSpec.describe Country, type: :model do
  describe "create country" do
    describe "with non root target group" do
      it "fails to create country" do
        target_group_leaf = TargetGroup.find_or_create_by_path([
            {name: "Root target group"},
            {name: "tg_level_1"},
            {name: "tg_level_2"},
            {name: "tg_level_3"},
            {name: "tg_level_4"}
          ]
        )
        panel_provider = FactoryGirl.create :panel_provider
        country = Country.new({country_code: "My Country", target_groups: [target_group_leaf], panel_provider: panel_provider})
        country.validate
        expect(country.valid?).to be false
        expect(country.errors[:target_groups]).to_not be_empty
      end
    end

    describe "with root target group" do
      it "succeeds to create country" do
        target_group_leaf = TargetGroup.find_or_create_by_path([
            {name: "Root target group"},
            {name: "tg_level_1"},
            {name: "tg_level_2"},
            {name: "tg_level_3"},
            {name: "tg_level_4"}
          ]
        )
        panel_provider = FactoryGirl.create :panel_provider
        country = Country.new({country_code: "My Country", target_groups: [target_group_leaf.root], panel_provider: panel_provider})
        country.validate
        expect(country.valid?).to be true
        expect(country.errors[:target_groups]).to be_empty
      end
    end

  end
end
