# == Schema Information
#
# Table name: transaktions
#
#  id          :bigint           not null, primary key
#  quantity    :integer
#  kind        :integer          default(0)
#  employee_id :bigint
#  company_id  :bigint
#  product_id  :bigint
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
