require 'rails_helper'

describe 'Company signin process', type: :feature, js: true do
  let!(:company) { create(:company) }
  it 'login' do
    visit '/companies/sign_in'
    within('form#new_company') do
      fill_in 'company_email', with: company.email
      fill_in 'company_password', with: company.password
    end
    click_button 'Log in'
    expect(page).to have_current_path(company_path(company.id))
  end
end
