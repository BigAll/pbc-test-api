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
              country = Country.find_by_country_code(params[:country_code])
              locations = []
              locations = country.locations if country
              present locations
            end
          end
        end

      end
    end
  end
end
