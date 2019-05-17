# == Schema Information
#
# Table name: menu_items
#
#  id         :bigint(8)        not null, primary key
#  quantity   :integer
#  product_id :bigint(8)
#  menu_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :menu_item do
    quantity { Faker::Number.number(2) }
    product
    menu
  end
end
