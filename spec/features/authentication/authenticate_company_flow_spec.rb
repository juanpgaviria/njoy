require 'rails_helper'

describe 'Company signin process', type: :feature, js: true do
  let!(:company) { create(:company) }
  it 'login' do
    visit '/'
    click_link 'Entrar'
    click_link 'Restaurante'
    expect(page).to have_current_path(new_company_session_path)

    within('form#new_company') do
      fill_in 'company_name', with: company.name
      fill_in 'company_password', with: company.password
    end
    click_button 'Entrar'
    expect(page).to have_current_path(new_employees_session_path)
    within('.ml-auto') do
      find('.dropdown-toggle').click
      click_link 'Salir'
    end
    expect(page).to have_current_path(root_path)
  end
end
