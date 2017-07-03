module PbcTest
  module V1
    module Private
      class PrivateAuth < Grape::API

        http_basic do |email, password|
          email && email == "admin" && password && password == "secret-password"
        end

        mount PbcTest::V1::Private::Locations
        mount PbcTest::V1::Private::TargetGroups

      end
    end
  end
end
