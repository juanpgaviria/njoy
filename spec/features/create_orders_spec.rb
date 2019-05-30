require 'rails_helper'

describe 'Orders', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company, password: '1234', role: 'admin') }
  let!(:product1) { create(:product, company: company, quantity: 10) }
  let!(:product2) { create(:product, company: company, quantity: 10) }
  let!(:menus) { create_list(:menu, 10, company: company) }
  let!(:categories) { create_list(:category, 5, company: company) }
  let!(:category) { categories.last }
  let!(:menu) { create(:menu, company: company, category: category) }
  let!(:menu1) { create(:menu, company: company, category: categories.first) }
  let!(:menu_item1) { create(:menu_item, product: product1, quantity: 9, menu: menu) }
  let!(:menu_item2) { create(:menu_item, product: product2, quantity: 15, menu: menu) }
  let!(:boards) { create_list(:board, 5, company: company, status: :free) }
  let!(:board) { boards.first }

  before do
    sign_in company
    visit '/'
  end

  it 'create, update, and close order' do
    fill_in 'password', with: 1234
    click_button 'Entrar'

    # create an order
    find("#board-#{board.id}").click
    expect(page).to have_current_path(new_board_order_path(board))
    expect(page).to have_css('.btn-group > a', count: 2)
    expect(page).to have_css('.menus > a', count: 1)
    expect(page).to have_css('tbody.order-items > tr', count: 1)
    expect(page).to have_content('$0')
    click_link menu1.name
    expect(page).to have_css('tbody.order-items > tr', count: 2)
    expect(page).to have_content("$#{menu1.price}")
    expect(page).to have_css('.remove_fields', count: 1)
    click_link category.name
    click_link menu.name
    expect(page).to have_css('tbody.order-items > tr', count: 3)
    page.all('.nested-fields')[1].find('a.remove_fields').click
    expect(page).to have_css('tbody.order-items > tr', count: 2)
    expect(page).to have_content("$#{menu.price}")
    click_button 'Crear'
    expect(page).to have_current_path(boards_path)
    expect(page).to have_content('Orden creada exitosamente')
    expect(page).to have_css("#board-#{board.id}.with_order", count: 1)

    # edit order
    find("#board-#{board.id}").click
    expect(page).to have_css('tbody.order-items > tr', count: 2)
    expect(page).to have_current_path(edit_board_order_path(board, Order.first))
    click_link menu1.name
    expect(page).to have_css('tbody.order-items > tr', count: 3)
    click_button 'Actualizar'
    expect(page).to have_current_path(boards_path)
    expect(page).to have_content('Orden actualizada exitosamente')
    expect(page).to have_css("#board-#{board.id}.with_order", count: 1)

    # close order
    find("#board-#{board.id}").click
    expect(page).to have_css('tbody.order-items > tr', count: 3)
    expect(page).to have_current_path(edit_board_order_path(board, Order.first))
    click_link 'Cerrar'
    expect(page).to have_current_path(boards_path)
    expect(page).to have_css("#board-#{board.id}.free", count: 1)
    expect(product1.reload.quantity).to eq 1
    expect(product2.reload.quantity).to eq(-5)
  end
end
