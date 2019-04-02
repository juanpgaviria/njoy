module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_company
      flash.clear
      redirect_to company_path(current_company)
    elsif current_user
      flash.clear
      redirect_to companies_path
    end
  end
end
