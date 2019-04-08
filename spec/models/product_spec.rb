# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  quantity    :string
#  price       :string
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
  it { should belong_to(:company) }
  it { should belong_to(:supplier) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:description) }
end
