class EmployeeForms
  constructor: () ->
    $('.pin').on('keydown', @verify_integer_input)
    $('.create-employee').on('click', @verify_passwords)

  verify_integer_input: (e) ->
    if (isNaN(parseInt(e.key)) && e.keyCode > 28)
      e.preventDefault()

  verify_passwords: (e) ->
    if ($('#employee_password').val() != $('#password_confirmation').val())
      e.preventDefault()
      $('.invalid-feedback').html('Los Pin no coinciden.')
      $('#password_confirmation').addClass('is-invalid')

window.EmployeeForms = EmployeeForms
