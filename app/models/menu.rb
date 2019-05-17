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

class Menu < ApplicationRecord
  belongs_to :company
  belongs_to :category
  has_many :menu_items, inverse_of: :menu, dependent: :destroy
  has_many :products, through: :menu_items
  accepts_nested_attributes_for :menu_items, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :name, :price
  validates :menu_items, length: { minimum: 1 }
end
