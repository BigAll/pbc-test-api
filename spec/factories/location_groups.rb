FactoryGirl.define do
  factory :location_group do
    name "MyLocationGroup"
    association :country, factory: :country
  end
end
