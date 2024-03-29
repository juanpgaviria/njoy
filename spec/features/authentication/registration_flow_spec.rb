require 'rails_helper'

describe 'User registration', type: :feature, js: true do
  before do
    visit '/'
  end

  it 'success' do
    click_link 'Registrate'

    within('.new_user') do
      fill_in 'user_email', with: 'njoy@gmail.com'
      fill_in 'user_password', with: 'test123'
      fill_in 'user_password_confirmation', with: 'test1234'
      click_button 'Registrarse'
      expect(page).to have_css('#error_explanation')
      fill_in 'user_password', with: 'test123'
      fill_in 'user_password_confirmation', with: 'test123'
      click_button 'Registrarse'
    end

    expect(page).to have_current_path(companies_path)
    expect(User.count).to eq 1
  end
end
