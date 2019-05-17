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

class MenuItem < ApplicationRecord
  belongs_to :product
  belongs_to :menu

  validates :quantity, presence: true
end
