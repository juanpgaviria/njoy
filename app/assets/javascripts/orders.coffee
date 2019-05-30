# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class TakeAnOrder
  constructor: (options) ->
    @total = parseInt(options.total)
    $('.orders').on('cocoon:after-insert', @add_item)
    $('.order-items').on('click', '.remove_fields', @remove_item)

  add_item: (event, elementInserted) =>
    @calculate_total(elementInserted, 'add')

  remove_item: (event) =>
    @calculate_total($(event.currentTarget).closest('tr'), 'remove')

  calculate_total: (order_item, event_type) =>
    if event_type == 'add'
      @total += parseInt(order_item.data().price)
    else
      @total -= parseInt(order_item.data().price)
    $('.order-total').html('$' + @total)
    $('#order_total').val(@total)

window.TakeAnOrder = TakeAnOrder
