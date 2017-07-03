require 'pbc_test/api'

module PbcTest

  class PbcTestApi < Grape::API
    prefix 'api'
    version 'v1', using: :path
    mount PbcTest::Api
  end
end