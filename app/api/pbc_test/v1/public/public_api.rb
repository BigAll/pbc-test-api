module PbcTest
  module V1
    module Public
      class PublicApi < Grape::API

        mount PbcTest::V1::Public::Locations
        mount PbcTest::V1::Public::TargetGroups

      end
    end
  end
end
