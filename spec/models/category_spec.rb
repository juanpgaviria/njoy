# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  company_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:company) }
  it { should have_many(:products) }
  it { should have_many(:menus) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
