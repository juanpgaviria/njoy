require 'rails_helper'

describe 'Employee signin process', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company, password: '1234') }
  before { sign_in company }

  it 'create and login employee flow' do
    visit '/'
    click_link 'Empleados'
    click_link 'Crear empleado'

    expect(page).to have_current_path(new_employee_path)
    within('form#new_employee') do
      fill_in 'employee_names', with: Faker::Name.name
      fill_in 'employee_last_names', with: Faker::Name.last_name
      fill_in 'employee_phone', with: Faker::PhoneNumber.phone_number
      fill_in 'employee_email', with: Faker::Internet.email
      page.select (Date.current - 1.years).year, from: 'employee_start_date_1i'
      page.select (Date.current - 1.years).strftime('%B'), from: 'employee_start_date_2i'
      page.select (Date.current - 1.years).day, from: 'employee_start_date_3i'
      page.select (Date.current - 20.years).year, from: 'employee_birthday_1i'
      page.select (Date.current - 20.years).strftime('%B'), from: 'employee_birthday_2i'
      page.select (Date.current - 20.years).day, from: 'employee_birthday_3i'
      fill_in 'employee_address', with: Faker::Address.full_address
      fill_in 'employee_identification', with: Faker::Number.number(10)
      fill_in 'employee_state', with: Faker::Address.state
      fill_in 'employee_city', with: Faker::Address.city
      fill_in 'employee_password', with: 'Dont let to write letters'
      fill_in 'password_confirmation', with: 'Dont let to write letters'
      expect(find_field('employee_password').value).to eq ''
      expect(find_field('password_confirmation').value).to eq ''
      fill_in 'employee_password', with: '1234'
      expect(find_field('employee_password').value).to eq '1234'
      fill_in 'password_confirmation', with: '12345'
      click_button 'Crear'
      expect(page).to have_content('Los Pin no coinciden.')
      fill_in 'password_confirmation', with: '1234'
      click_button 'Crear'
      expect(page).to have_content('Password has already been taken')
      fill_in 'employee_password', with: '12345'
      fill_in 'password_confirmation', with: '12345'
      click_button 'Crear'
    end
    expect(page).to have_current_path(employee_path(Employee.last))

    click_link 'Empleado'
    expect(page).to have_current_path(new_employees_session_path)

    within('form') do
      fill_in 'password', with: 'Dont let to write letters'
      expect(find_field('password').value).to eq ''
      fill_in 'password', with: '125'
      click_button 'Entrar'
      fill_in 'password', with: '12345'
    end
    expect(page).to have_content('Pin incorrecto')
    click_button 'Entrar'
    expect(page).to have_current_path(company_path(company.id))
    click_link "Salir #{Employee.last.names}"
    expect(page).to have_current_path(company_path(company.id))
  end
end
