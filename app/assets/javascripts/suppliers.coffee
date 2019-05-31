# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class SupplierTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#suppliers-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url:$('#suppliers-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'name' }
        { data: 'phone' }
        { data: 'contact_name' }
        { data: 'products' }
        { data: 'actions' }
      ]

window.SupplierTable = SupplierTable
