module NavbarHelper
  def root_title
    company_signed_in? ? current_company.name.titleize : 'nJoy'
  end
end
