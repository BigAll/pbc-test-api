module PbcTest
  module V1
    module Public
      class Locations < Grape::API

        namespace 'public' do
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
