# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  quantity    :integer
#  price       :decimal(, )
#  description :string
#  brand       :string
#  category_id :bigint(8)
#  supplier_id :bigint(8)
#  company_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { create(:product, quantity: 10) }

  it { should belong_to(:company) }
  it { should belong_to(:supplier) }
  it { should belong_to(:category) }
  it { should have_many(:menu_items) }
  it { should have_many(:menus).through(:menu_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:description) }

  it 'should substract quantity' do
    product.substract_product(9)
    expect(product.quantity).to eq 1
  end
end
