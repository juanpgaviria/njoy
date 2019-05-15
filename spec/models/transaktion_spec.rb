# == Schema Information
#
# Table name: transaktions
#
#  id          :bigint           not null, primary key
#  quantity    :integer
#  kind        :integer          default(0)
#  employee_id :bigint
#  company_id  :bigint
#  product_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Transaktion, type: :model do
  it { should belong_to(:company) }
  it { should belong_to(:employee) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:kind) }
end
