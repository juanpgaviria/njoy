class OrderPolicy < ApplicationPolicy
  def new?
    @employee.admin? || @employee.cashman? || @employee.waiter?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def edit?
    new?
  end
end
