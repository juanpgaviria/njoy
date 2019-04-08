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

class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :company

  validates :name, presence: true, uniqueness: { scope: :company_id }
  validates :description, presence: true
end
