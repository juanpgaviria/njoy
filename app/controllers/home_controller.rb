class HomeController < ApplicationController
  def index
    return redirect_to companies_path if current_user
    return redirect_to boards_path if current_employee
    return redirect_to new_employees_session_path if current_company
  end
end
