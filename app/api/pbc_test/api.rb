module PbcTest
  class Api < Grape::API
    default_format :json
    format :json

    mount PbcTest::V1::Private::PrivateApi
    mount PbcTest::V1::Public::PublicApi

  end
end
