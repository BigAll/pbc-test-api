module PbcTest
  module V1
    module Public
      class TargetGroups < Grape::API

        namespace 'public' do
          resource :target_groups do
            desc 'get locations'
            params do
              requires :country_code, type: String, desc: 'code of the country to get target groups'
            end
            get '/:country_code' do
              target_groups = Country.find_by_country_code(params[:country_code]).target_groups
              present target_groups
            end
          end
        end

      end
    end
  end
end