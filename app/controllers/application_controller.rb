class ApplicationController < ActionController::Base
  include Pundit
  helper_method :current_session
  helper_method :current_employee
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def employee_sign_in(employee)
    cookies[:employee_id] = { value: employee.id, expires: 10.minutes }
    @current_employee = employee
  end

  def employee_sign_out
    cookies.delete(:employee_id)
    @current_employee = nil
  end

  def authenticate_employee!
    redirect_to new_employees_session_path unless current_employee
  end

  def pundit_user
    current_employee
  end

  protected

  def authenticate_admin!
    return authenticate_employee! unless current_employee

    authorize current_employee, :admin?
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

  def user_not_authorized
    redirect_to root_path, notice: 'No tienes acceso a este recurso'
  end
end
