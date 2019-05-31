# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class TransaktionTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#transaktions-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url:$('#transaktions-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'product' }
        { data: 'kind' }
        { data: 'quantity' }
        { data: 'actions' }
      ]

window.TransaktionTable = TransaktionTable
