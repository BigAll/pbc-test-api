require 'validations/valid_target_group'
require 'validations/valid_locations'

module PbcTest
  module V1
    module Private
      class TargetGroups < PrivateApi

        namespace 'private' do
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

          desc 'evaluate target'
          params do
            requires :country_code, type: String, desc: 'code of the country'
            requires :target_group_id, type: Numeric, desc: 'target group ID', valid_target_group: true
            requires :locations, type: Array, valid_locations: true do
              requires :id, type: Numeric, desc: 'location ID'
              requires :panel_size, type: Numeric, desc: 'some kind of number'
            end
          end
          post '/evaluate_target' do
            service = ::Private::CountryService.new(params)
            present service.calculate_price
          end

        end
      end
    end
  end
end
