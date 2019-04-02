class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :authenticate_company!, unless: :user_signed_in?, only: :show

  def index
    @companies = current_user.companies
  end

  def show
    @company = current_company || current_user.companies.find(params[:id])
  end
end
