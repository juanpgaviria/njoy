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

class Transaktion < ApplicationRecord
  belongs_to :employee
  belongs_to :company
  belongs_to :product

  validates :quantity, :kind, presence: true
  validate :enough_quantity

  before_create :update_quantity

  enum kind: %i[deposit withdraw]

  def enough_quantity
    return true unless withdraw? && (product.quantity < quantity)

    not_stock_error = 'La cantidad a restar no puede ser mayor a la cantidad existente'
    errors.add(:quantity_insufficient, not_stock_error)
  end

  private

  def update_quantity
    product.update(quantity: product.quantity + quantity) if deposit?
    product.update(quantity: product.quantity - quantity) if withdraw?
  end
end
