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

require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it { should belong_to(:product) }
  it { should belong_to(:menu) }
  it { should validate_presence_of(:quantity) }
end
