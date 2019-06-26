class AttendancesController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_employee!

  def destroy
    @attendance = current_employee.attendances.last
    @attendance.update_attribute(:end_time, Time.now)
    current_employee.inactive!
    employee_sign_out
    redirect_to new_employees_session_path
  end
end
