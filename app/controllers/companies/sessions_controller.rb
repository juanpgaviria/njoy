# frozen_string_literal: true

class Companies::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  before_action :configure_sign_in_params

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    employee_sign_out if current_employee
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email])
  end
end
