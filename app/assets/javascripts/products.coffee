# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class ProductTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#products-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url: $('#products-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'name' }
        { data: 'price' }
        { data: 'quantity' }
        { data: 'actions' }
      ]

window.ProductTable = ProductTable
