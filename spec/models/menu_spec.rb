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

require 'rails_helper'

RSpec.describe Menu, type: :model do
  it { should belong_to(:company) }
  it { should belong_to(:category) }
  it { should have_many(:menu_items) }
  it { should have_many(:products).through(:menu_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
