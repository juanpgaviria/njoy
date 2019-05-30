# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  status     :integer          default("open")
#  total      :integer          default(0)
#  company_id :bigint(8)
#  board_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :company
  belongs_to :board
  has_many :order_items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  enum status: %i[open close]
  validate :board_free?, on: :create
  before_create :change_board_status
  after_update :close_order, if: ->(a) { a.close? }

  def board_free?
    return unless board.nil? || !board.free?

    errors.add(:board_bussy, 'La mesa no esta disponible')
  end

  private

  def change_board_status
    return board.with_order! if board.free?
    return board.free! if board.with_order?
  end

  def close_order
    substrac_products
    change_board_status
    # TODO: Generate invoice
  end

  def substrac_products
    order_items.each do |order_item|
      order_item.menu.menu_items.each do |menu_item|
        menu_item.product.substract_product(menu_item.quantity)
      end
    end
  end
end
