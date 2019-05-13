# == Schema Information
#
# Table name: boards
#
#  id         :bigint(8)        not null, primary key
#  number     :integer
#  pos_x      :integer
#  pos_y      :integer
#  width      :integer
#  height     :integer
#  company_id :bigint(8)
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :board do
    number { Faker::Number.number(2) }
    sequence(:pos_x, (100..700).step(100).cycle) { |pos| pos }
    sequence(:pos_y, (100..700).step(100).cycle) { |pos| pos }
    width { 100 }
    height { 100 }
    status { Faker::Number.between(0, 2) }
    company
  end
end
