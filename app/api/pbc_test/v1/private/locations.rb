module PbcTest
  module V1
    module Private
      class Locations < PrivateApi

        namespace 'private' do
          resource :locations do
            params do
              requires :country_code, type: String, desc: 'code of the country to get locations'
            end
            get '/:country_code' do
              service = ::Public::LocationsService.new(params)
              present service.get_locations
            end
          end
        end

      end
    end
  end
end
