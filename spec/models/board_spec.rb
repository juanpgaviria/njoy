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

require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should belong_to(:company) }
  it { should validate_presence_of(:number) }
end
