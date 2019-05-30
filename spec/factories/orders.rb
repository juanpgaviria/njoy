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

FactoryBot.define do
  factory :order do
    status { :open }
    company
    board
  end
end
