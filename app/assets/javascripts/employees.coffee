class EmployeePin
  constructor: () ->
    $('.set-pin').on('keydown', @verify_integer_input)
    $('.create-employee').on('click', @verify_passwords)

  verify_integer_input: (e) ->
    if (isNaN(parseInt(e.key)) && e.keyCode > 28)
      e.preventDefault()

  verify_passwords: (e) ->
    if ($('.pin').val() != $('.pin-confirmation').val())
      e.preventDefault()
      $('.invalid-feedback').html('Los Pin no coinciden.')
      $('.pin-confirmation').addClass('is-invalid')

window.EmployeePin = EmployeePin

class EmployeeTable
  constructor: () ->
    @initializeDatatable()

  initializeDatatable: () ->
    $('#employees-datatable').dataTable
      processing: true
      serverSide: true
      ajax:
        url: $('#employees-datatable').data('source')
      pagingType: 'full_numbers'
      columns: [
        { data: 'names' }
        { data: 'last_names'}
        { data: 'phone' }
        { data: 'email' }
        { data: 'status' }
        { data: 'actions' }
      ]

window.EmployeeTable = EmployeeTable
