# == Schema Information
#
# Table name: order_items
#
#  id         :bigint(8)        not null, primary key
#  menu_id    :bigint(8)
#  order_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :order_item do
    menu { nil }
    order { nil }
  end
end
