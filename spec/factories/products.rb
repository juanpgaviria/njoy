# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  quantity    :string
#  price       :string
#  description :string
#  brand       :string
#  category_id :bigint(8)
#  supplier_id :bigint(8)
#  company_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    quantity { Faker::Number.number(3) }
    price { Faker::Number.number(6) }
    description { Faker::Lorem.sentence }
    brand { Faker::Name.name }
    category
    supplier
    company
  end
end
