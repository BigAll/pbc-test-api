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
              service = ::Public::TargetGroupsService.new(params)
              present service.get_target_groups
            end
          end
        end

      end
    end
  end
end
