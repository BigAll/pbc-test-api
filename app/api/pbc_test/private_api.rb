module PbcTest
  class PrivateApi < Grape::API

    mount PbcTest::V1::Private::Locations
    mount PbcTest::V1::Private::TargetGroups

  end
end
