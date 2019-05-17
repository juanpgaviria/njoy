require 'rails_helper'

describe 'Menus', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company, password: '1234', role: 'admin') }
  let!(:products) { create_list(:product, 10, company: company) }
  let!(:product) { products.last }
  let!(:menus) { create_list(:menu, 15, company: company) }
  let!(:menu) { menus.first }
  let!(:categories) { create_list(:category, 5, company: company) }
  let!(:category) { categories.last }

  before do
    sign_in company
    visit '/'
  end

  it 'index, show, create, update, delete' do
    expect(page).to have_current_path(new_employees_session_path)
    fill_in 'password', with: 1234
    click_button 'Entrar'
    visit '/menus'
    # pagination
    expect(page).to have_css('tbody > tr', count: 10)
    expect(page).to have_css('.page-link', count: 6) # first, previous, 1, 2, next, last
    click_link '2'
    expect(page).to have_css('tbody > tr', count: 5)

    # New menu
    click_link 'Crear plato'
    within '#new_menu' do
      fill_in 'menu_name', with: 'Blanca Celeste'
      fill_in 'menu_price', with: '15000'
      page.all('.select2').first.click
    end
    # out the within because selec2 add dinamicaly a div at the bottom of the body
    expect(page).to have_css('.select2-results__options > li', count: 6)
    find('.select2-search__field').set(category.name)

    within '.select2-results__options' do
      expect(page).to have_css('.select2-results__options > li', count: 1)
      find('li', text: category.name).click
    end
    find('.nested-fields').find('a.remove_fields').click
    click_button 'Guardar'
    expect(page).to have_content('No se pudo guardar este menu')

    within '#new_menu' do
      page.all('.nested-fields').first.find('input.form-control').set(10)
      page.all('.select2')[1].click
    end
    expect(page).to have_css('.select2-results__options > li', count: 11)
    find('.select2-search__field').set(product.name)

    within '.select2-results__options' do
      expect(page).to have_css('.select2-results__options > li', count: 1)
      find('li', text: product.name).click
    end
    find('.add_fields').click
    expect(page).to have_css('.nested-fields', count: 2)

    within '#new_menu' do
      page.all('.nested-fields')[1].find('input.form-control').set(5)
      page.all('.select2')[2].click
    end

    find('.select2-search__field').set(products.first.name)
    within '.select2-results__options' do
      find('li', text: products.first.name).click
    end
    find('.add_fields').click
    page.all('.nested-fields')[2].find('a.remove_fields').click
    expect(page).to have_css('.nested-fields', count: 2)
    click_button 'Guardar'

    expect(page).to have_current_path(menu_path(Menu.last))
    expect(page).to have_content('Plato del menu creado exitosamente')
    expect(page).to have_content(Menu.last.name)
    expect(page).to have_css('tbody > tr', count: 2)

    # search for new menu in index
    click_link 'Ver platos'
    expect(page).to have_current_path(menus_path)
    find('#menus-datatable_filter input').set(Menu.last.name)
    expect(page).to have_css('tbody > tr', count: 1)

    # edit last menu
    click_link 'Editar'
    within '.edit_menu' do
      expect(page).to have_css('.nested-fields', count: 2)
      fill_in 'menu_name', with: 'Blanca Celeste Updated'
      find('.add_fields').click
      page.all('.nested-fields')[2].find('select').select(Product.find(2).name)
      page.all('.nested-fields')[2].find('input.form-control').set(1)
      click_button 'Guardar'
    end
    expect(page).to have_current_path(menu_path(Menu.last))
    expect(page).to have_content('Plato del menu actualizado exitosamente')
    expect(page).to have_content(Menu.last.name)
    expect(page).to have_css('tbody > tr', count: 3)

    # delete menu
    click_link 'Borrar Plato'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path(menus_path)
    find('.custom-select').select(25)
    expect(page).to have_css('tbody > tr', count: 15)
  end
end
