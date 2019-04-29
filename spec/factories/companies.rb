# == Schema Information
#
# Table name: companies
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string(100)
#  phone                  :string(100)
#  identification         :string(100)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint(8)
#

FactoryBot.define do
  factory :company do
    email { Faker::Internet.email }
    name { Faker::Company.unique.name }
    phone { Faker::PhoneNumber.cell_phone }
    identification { Faker::Number.number(10) }
    password { 'test123' }
    user
  end
end
