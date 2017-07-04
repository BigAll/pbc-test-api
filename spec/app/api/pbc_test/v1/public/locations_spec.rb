require 'rails_helper'

describe 'PbcTest::V1::Private::Locations' do
  let(:letters_panel_provider) { FactoryGirl.create :letters_panel_provider}
  let(:arrays_panel_provider) { FactoryGirl.create :arrays_panel_provider}
  let(:country) { FactoryGirl.create :country, panel_provider: letters_panel_provider}

  let(:location1) { FactoryGirl.create :location}
  let(:location2) { FactoryGirl.create :location}
  let(:location3) { FactoryGirl.create :location}
  let!(:location_group1) { FactoryGirl.create :location_group, locations: [location1, location2, location3], country: country, panel_provider: letters_panel_provider}

  let(:location4) { FactoryGirl.create :location}
  let(:location5) { FactoryGirl.create :location}
  let(:location6) { FactoryGirl.create :location}
  let!(:location_group2) { FactoryGirl.create :location_group, locations: [location4, location5, location6], country: country, panel_provider: letters_panel_provider}

  let(:location7) { FactoryGirl.create :location}
  let(:location8) { FactoryGirl.create :location}
  let(:location9) { FactoryGirl.create :location}
  let!(:location_group3) { FactoryGirl.create :location_group, locations: [location7, location8, location9], country: country, panel_provider: arrays_panel_provider}

  context 'unauthorized user' do
    context 'when requests GET /api/v1/public/locations' do
      it 'retrieves empty list for inexistent country' do
        get "/api/v1/public/locations/Russia"
        expect(response.status).to eq(200)
        expect(response.body).to eq("[]")
      end

      it 'retrieves locations list for existent country' do
        get "/api/v1/public/locations/MyCountry"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to eq 6
      end
    end
  end

  context 'authorized user' do
    context 'when requests GET /api/v1/public/locations' do
      it 'retrieves empty list for inexistent country' do
        get "/api/v1/public/locations/Russia", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(response.body).to eq("[]")
      end

      it 'retrieves locations list for existent country' do
        get "/api/v1/public/locations/MyCountry", {},
          { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret-password") }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to eq 6
      end
    end
  end
end
