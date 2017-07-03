require 'rails_helper'

describe 'PbcTest::V1::Private::TargetGroups' do
  let(:target_group_tree1) { TargetGroup.find_or_create_by_path([
      {name: "Root_TG1"},
      {name: "TG1_level_1"},
      {name: "TG1_level_2"},
      {name: "TG1_level_3"},
      {name: "TG1_level_4"}
    ]
  )
  }
  let(:target_group_tree2) { TargetGroup.find_or_create_by_path([
      {name: "Root_TG2"},
      {name: "TG2_level_1"},
      {name: "TG2_level_2"},
      {name: "TG2_level_3"},
      {name: "TG2_level_4"}
    ]
  )
  }
  let!(:country) { FactoryGirl.create :country, target_groups: [target_group_tree1.root, target_group_tree2.root]}

  context 'unauthorized user' do
    context 'when requests GET /api/v1/public/targer_groups' do
      it 'retrieves empty list for inexistent country' do
        get "/api/v1/public/target_groups/Russia"
        expect(response.status).to eq(200)
        expect(response.body).to eq("[]")
      end

      it 'retrieves locations list for existent country' do
        get "/api/v1/public/target_groups/MyCountry"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to eq 2
      end
    end
  end

  context 'authorized user' do
    context 'when requests GET /api/v1/public/target_groups' do
      it 'retrieves empty list for inexistent country' do
        get "/api/v1/public/target_groups/Russia", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(response.body).to eq("[]")
      end

      it 'retrieves locations list for existent country' do
        get "/api/v1/public/target_groups/MyCountry", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to eq 2
      end
    end
  end
end
