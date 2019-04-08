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

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  belongs_to :company

  validates :name, :quantity, :price, :description, :brand, presence: true
end
