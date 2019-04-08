# == Schema Information
#
# Table name: suppliers
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  address        :string
#  city           :string
#  phone          :string
#  identification :string
#  contact_name   :string
#  company_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it { should belong_to(:company) }
  it { should have_many(:products) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:identification) }
  it { should validate_presence_of(:contact_name) }
  it { should validate_presence_of(:phone) }
end
