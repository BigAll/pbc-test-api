require 'rails_helper'

describe 'PbcTest::V1::Private::TargetGroups' do
  let(:letters_panel_provider) { FactoryGirl.create :letters_panel_provider}
  let(:arrays_panel_provider) { FactoryGirl.create :arrays_panel_provider}

  let(:location1) { FactoryGirl.create :location}
  let(:location2) { FactoryGirl.create :location}
  let(:location3) { FactoryGirl.create :location}

  let(:target_group_tree1) { TargetGroup.find_or_create_by_path([
      {name: "Root_TG1", panel_provider: letters_panel_provider},
      {name: "TG1_level_1", panel_provider: letters_panel_provider},
      {name: "TG1_level_2", panel_provider: letters_panel_provider},
      {name: "TG1_level_3", panel_provider: letters_panel_provider},
      {name: "TG1_level_4", panel_provider: letters_panel_provider}
    ]
  )
  }
  let(:target_group_tree2) { TargetGroup.find_or_create_by_path([
      {name: "Root_TG2", panel_provider: arrays_panel_provider},
      {name: "TG2_level_1", panel_provider: arrays_panel_provider},
      {name: "TG2_level_2", panel_provider: arrays_panel_provider},
      {name: "TG2_level_3", panel_provider: arrays_panel_provider},
      {name: "TG2_level_4", panel_provider: arrays_panel_provider}
    ]
  )
  }
  let(:country) { FactoryGirl.create :country, target_groups: [target_group_tree1.root, target_group_tree2.root], panel_provider: letters_panel_provider}
  let!(:location_group) { FactoryGirl.create :location_group, locations: [location1, location2, location3], country: country}

  context 'unauthorized user' do
    context 'when requests GET /api/v1/private/targer_groups' do
      it 'fails with 401 Unauthorized' do
        get "/api/v1/private/target_groups/Russia"
        expect(response.status).to eq(401)
      end
    end

    context 'when requests POST /api/v1/private/evaluate_target' do
      it 'fails with 401 Unauthorized' do
        post "/api/v1/private/evaluate_target"
        expect(response.status).to eq(401)
      end
    end
  end

  context 'authorized user' do
    context 'when requests GET /api/v1/private/target_groups' do
      it 'retrieves empty list for inexistent country' do
        get "/api/v1/private/target_groups/Russia", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(response.body).to eq("[]")
      end

      it 'retrieves locations list for existent country' do
        get "/api/v1/private/target_groups/MyCountry", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to eq 1 #because only one panel provider is similar for country and target group
      end
    end

    context 'when requests POST /api/v1/private/evaluate_target' do
      context 'when missing parameters' do
        it 'fails with 400 Bad Request' do
          post "/api/v1/private/evaluate_target", {},
            { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
          expect(response.status).to eq(400)
        end
      end

      context 'when invalid values for parameters' do
        it 'fails with 400 Bad Request' do
          post "/api/v1/private/evaluate_target",
            { country_code: "Russia", target_group_id: 1, locations: [{id: 1}, {id: 2}, {id: 3}] },
            { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
          expect(response.status).to eq(400)
        end
      end

      context 'when valid values for parameters' do
        it 'receives price for country based country on panel provider' do
          stub_request(:get, "http://time.com").to_return(body: "<html><body>Data Text</body></html>", status: 200)

          params = {
            country_code: "MyCountry",
            target_group_id: target_group_tree1.root.id.to_i,
            locations: [
              {id: location1.id, panel_size: 1},
              {id: location2.id, panel_size: 10},
              {id: location3.id, panel_size: 50}
            ]
          }
          post "/api/v1/private/evaluate_target", params.to_json,
            { CONTENT_TYPE: "application/json", HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
          expect(response.status).to eq(201)
        end
      end
    end

  end
end
