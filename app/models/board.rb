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
#  status     :integer          default("free")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ApplicationRecord
  belongs_to :company
  has_many :orders
  validates :number, presence: true
  validates_uniqueness_of :number, scope: :company_id

  enum status: %i[free with_order busy]
end
