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

class OrderItem < ApplicationRecord
  belongs_to :menu
  belongs_to :order
end
