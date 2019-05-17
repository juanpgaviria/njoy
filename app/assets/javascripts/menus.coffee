# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class MenuTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#menus-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url: $('#menus-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'name' }
        { data: 'price' }
        { data: 'category' }
        { data: 'actions' }
      ]

window.MenuTable = MenuTable
