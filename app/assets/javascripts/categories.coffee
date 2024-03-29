# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class CategoryTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#categories-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url: $('#categories-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'name' }
        { data: 'description' }
        { data: 'products' }
        { data: 'actions'}
      ]

window.CategoryTable = CategoryTable
