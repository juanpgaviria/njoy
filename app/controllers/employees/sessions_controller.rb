class Employees::SessionsController < ApplicationController
  before_action :authenticate_company!

  def create
    employee = current_company.employees.find_by_password(encrypted_password)
    if employee
      employee_sign_in(employee)
      redirect_to root_path
    else
      flash[:alert] = 'Pin incorrecto'
      render :new
    end
  end

  def destroy
    employee_sign_out if current_employee
    redirect_to root_path
  end

  private

  def session_params
    params.permit(:password)
  end

  def encrypted_password
    Digest::SHA256.digest(session_params[:password])
  end
end
