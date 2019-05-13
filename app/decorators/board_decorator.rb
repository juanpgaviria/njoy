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
end
