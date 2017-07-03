require 'rails_helper'

describe 'PbcTest::V1::Private::Locations' do
  let(:location1) { FactoryGirl.create :location}
  let(:location2) { FactoryGirl.create :location}
  let(:location3) { FactoryGirl.create :location}
  let!(:location_group) { FactoryGirl.create :location_group, locations: [location1, location2, location3]}

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
        expect(JSON.parse(response.body).size).to eq 3
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
        expect(JSON.parse(response.body).size).to eq 3
      end
    end
  end
end
