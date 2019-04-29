require 'rails_helper'

describe 'User can create a company', type: :feature, js: true do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  before do
    sign_in user
    visit '/companies'
  end

  it 'success' do
    click_link 'Crear Restaurante'

    within('.new_company') do
      fill_in 'company_email', with: 'njoy@gmail.com'
      fill_in 'company_password', with: 'test123'
      click_button 'Crear'
      fill_in 'company_password_confirmation', with: 'test123'
      fill_in 'company_name', with: 'njoy'
      fill_in 'company_phone', with: '3148112185'
      fill_in 'company_identification', with: '1128402392'
      fill_in 'password', with: '1234'
      fill_in 'password_confirmation', with: 'dont let write letters'
      expect(find_field('password_confirmation').value).to eq ''
      fill_in 'password_confirmation', with: '1234'
      click_button 'Crear'
    end

    expect(page).to have_current_path(company_path(Company.first))
    expect(Company.count).to eq 1
    expect(Company.first.employees.count).to eq 1
  end
end
