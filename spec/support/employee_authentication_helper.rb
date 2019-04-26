module EmployeeModule
  def sign_in_employee
    post '/employees/sessions', params: { password: '1234' }
  end
end
