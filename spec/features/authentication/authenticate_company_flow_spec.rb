require 'rails_helper'

describe 'Company signin process', type: :feature, js: true do
  let!(:company) { create(:company) }
  it 'login' do
    visit '/'
    click_link 'Entrar'
    click_link 'Restaurante'
    expect(page).to have_current_path(new_company_session_path)

    within('form#new_company') do
      fill_in 'company_email', with: company.email
      fill_in 'company_password', with: company.password
    end
    click_button 'Entrar'
    expect(page).to have_current_path(company_path(company.id))
    click_link company.name.titleize
    click_link 'Salir'
    expect(page).to have_current_path(root_path)
  end
end
