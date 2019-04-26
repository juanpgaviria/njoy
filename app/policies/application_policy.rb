# Pundit, used for authorizations for employees roles
class ApplicationPolicy
  attr_reader :employee, :resource

  def initialize(employee, resource)
    @employee = employee
    @resource = resource
  end

  def admin?
    @employee.admin?
  end
end
