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

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:menu) }
  it { should belong_to(:order) }
end
