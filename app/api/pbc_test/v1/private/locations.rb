module PbcTest
  module V1
    module Private
      class Locations < PrivateAuth

        namespace 'private' do
          resource :locations do
            params do
              requires :country_code, type: String, desc: 'code of the country to get locations'
            end
            get '/:country_code' do
              locations = Country.find_by_country_code(params[:country_code]).locations
              present locations
            end
          end
        end

      end
    end
  end
end
