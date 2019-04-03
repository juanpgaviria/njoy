class ApplicationController < ActionController::Base
  helper_method :current_session

  def current_session
    current_company || current_user
  end
end
