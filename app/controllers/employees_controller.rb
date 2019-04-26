class EmployeesController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_admin!
  before_action :find_employee, except: %i[index new create]

  def index
    @employees = current_company.employees.all
  end

  def new
    @employee = current_company.employees.new
  end

  def create
    @employee = current_company.employees.new(employee_params)
    if @employee.save
      flash[:notice] = 'Empleado creado exitosamente'
      redirect_to employee_path(@employee)
    else
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      flash[:notice] = 'Empleado actualizado exitosamente'
      redirect_to employee_path(@employee)
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy!
    flash[:notice] = 'Empleado eliminado exitosamente'
    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:names, :last_names, :phone, :address, :state, :city,
                                     :identification, :password, :birthday, :start_date,
                                     :email, :role)
  end

  def find_employee
    @employee = current_company.employees.find(params[:id])
  end
end
