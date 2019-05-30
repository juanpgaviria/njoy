# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  status     :integer          default("open")
#  total      :integer          default(0)
#  company_id :bigint(8)
#  board_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:board) { FactoryBot.create(:board, status: :free) }
  let!(:order) { FactoryBot.create(:order, board: board) }
  it { should belong_to(:company) }
  it { should belong_to(:board) }
  it { should have_many(:order_items) }

  it 'change board status to with_order' do
    expect(order.board.with_order?).to be_truthy
  end

  it 'close order' do
    order.close!
    expect(order.board.free?).to be_truthy
  end
end
