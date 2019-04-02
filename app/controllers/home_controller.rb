class HomeController < ApplicationController
  def index
    return redirect_to companies_path if current_user
    return redirect_to company_path(current_company) if current_company
  end
end
