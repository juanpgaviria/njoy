class BoardDecorator < ApplicationDecorator
  delegate_all

  def draggable?(controller, action)
    actions_array = %w[positions create update]
    return 'draggable' if controller == 'boards' && actions_array.include?(action)
  end

  def board_color
    return 'free' if free?
    return 'busy' if busy?
    return 'with_order' if with_order?
  end

  def clickable?(controller, action)
    return true if controller == 'boards' && action == 'index'

    false
  end

  def url
    return "/boards/#{id}/orders/#{orders.open.first.id}/edit" if with_order?
    return "/boards/#{id}/orders/new" if free?
    return '' if busy?
  end
end
