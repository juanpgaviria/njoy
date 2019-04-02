require 'rails_helper'

describe 'User signin process', type: :feature, js: true do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  it 'sign in and sign out' do
    visit '/users/sign_in'

    within('form#new_user') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
    end
    expect(page).to have_current_path(companies_path)
    click_link 'Salir'
    expect(page).to have_current_path(root_path)
  end
end
