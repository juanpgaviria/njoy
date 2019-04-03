require 'rails_helper'

describe 'User signin process', type: :feature, js: true do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  it 'sign in and sign out' do
    visit '/'

    click_link 'Entrar'
    click_link 'Dueño'
    expect(page).to have_current_path(new_user_session_path)

    within('form#new_user') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      click_button 'Entrar'
    end
    expect(page).to have_current_path(companies_path)
    click_link user.email.split('@')[0].titleize
    click_link 'Salir'
    expect(page).to have_current_path(root_path)
  end
end
