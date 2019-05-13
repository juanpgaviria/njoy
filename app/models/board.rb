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

class Board < ApplicationRecord
  belongs_to :company

  validates :number, presence: true

  enum status: %i[free with_order busy]
end
