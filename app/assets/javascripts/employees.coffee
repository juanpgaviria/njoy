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
