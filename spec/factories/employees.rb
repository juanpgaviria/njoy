# == Schema Information
#
# Table name: employees
#
#  id             :bigint(8)        not null, primary key
#  names          :string(100)
#  last_names     :string(100)
#  address        :string
#  state          :string
#  city           :string
#  identification :string
#  phone          :string(100)
#  email          :string(100)
#  birthday       :date
#  start_date     :date
#  password       :binary
#  company_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :employee do
    names { Faker::Name.name }
    last_names { Faker::Name.last_name }
    address { Faker::Address.full_address }
    state { Faker::Address.state }
    city { Faker::Address.city }
    identification { Faker::Number.number(10) }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    birthday { Faker::Date.between(60.years.ago, 18.years.ago) }
    start_date { Faker::Date.between(1.years.ago, Date.today) }
    password { Faker::Number.unique.number(5) }
    company
  end
end
