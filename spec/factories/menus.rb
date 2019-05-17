# == Schema Information
#
# Table name: menus
#
#  id          :bigint(8)        not null, primary key
#  company_id  :bigint(8)
#  name        :string
#  category_id :bigint(8)
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :menu do
    name { Faker::Food.dish }
    price { Faker::Number.number(5) }
    company
    category
    before(:create) { |menu| menu.menu_items << FactoryBot.create(:menu_item, menu: menu) }
  end
end
