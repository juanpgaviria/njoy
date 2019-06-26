# Pundit policies
class EmployeePolicy < ApplicationPolicy
  def index?
    @employee.admin?
  end

  def show?
    @employee.id == @resource.id || @employee.admin?
  end
end
