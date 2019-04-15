class ApplicationController < ActionController::Base
  helper_method :current_session
  helper_method :current_employee

  def employee_sign_in(employee)
    cookies[:employee_id] = { value: employee.id, expires: 10.minutes }
    @current_employee = employee
  end

  def employee_sign_out
    cookies.delete(:employee_id)
    @current_employee = nil
  end

  private

  def current_employee
    @current_employee ||= if current_company && cookies[:employee_id]
                            current_company.employees.find(cookies[:employee_id])
                          end
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def current_session
    current_company || current_user
  end
end
