# == Schema Information
#
# Table name: suppliers
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  address        :string
#  city           :string
#  phone          :string
#  identification :string
#  contact_name   :string
#  company_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :supplier do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.phone_number }
    identification { Faker::IDNumber.valid }
    contact_name { Faker::Name.name }
    company
  end
end
