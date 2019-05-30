# == Schema Information
#
# Table name: transaktions
#
#  id          :bigint(8)        not null, primary key
#  quantity    :integer
#  kind        :integer          default("deposit")
#  employee_id :bigint(8)
#  company_id  :bigint(8)
#  product_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :transaktion do
    quantity { Faker::Number.number(2) }
    employee
    company
    product
  end
end
