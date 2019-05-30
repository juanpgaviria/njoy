require 'rails_helper'

describe 'Boards Layout', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company, password: '1234', role: 'admin') }
  let!(:boards) { create_list(:board, 2, company: company) }
  let!(:board) { boards.first }
  let!(:free_board) { create(:board, status: :free, company: company) }
  let!(:busy_board) { create(:board, status: :busy, company: company) }
  let!(:with_order_board) { create(:board, status: :free, company: company) }
  let!(:order) do
    create(:order, company: company, board: with_order_board)
  end

  before do
    sign_in company
    visit root_path
  end

  it 'editing layout success' do
    with_order_board.with_order!
    expect(page).to have_current_path(new_employees_session_path)
    fill_in 'password', with: 1234
    click_button 'Entrar'
    expect(page).to have_current_path(boards_path)
    expect(page).to have_css('.board', count: 5)
    expect(page).to have_css("#board-#{free_board.id}.free")
    expect(page).to have_css("#board-#{busy_board.id}.busy")
    expect(page).to have_css("#board-#{with_order_board.id}.with_order")
    click_link 'Mesas'
    expect(page).to have_css('.draggable', count: 5)
    expect(page).to have_css('.board', count: 5)
    board_div = find("#board-#{board.id}")

    # Dragging
    board_div.drag_by(0, 10)
    expect(page).to have_css("#board-#{board.id}")
    expect(board_div.native.style('transform')).to_not eq 'matrix(1, 0, 0, 1, 100, 100)'
    sleep 0.9
    expect(board_div['data-x']).to_not have_text('100')
    expect(board.reload.pos_y).to_not have_text(100)
    expect(board.pos_x).to_not have_text(100)

    # Resizing
    border_div_resize(board_div, 150, 150)
    sleep 0.9
    expect(board.reload.width).to have_text(300)
    expect(board.height).to have_text(300)
    border_div_resize(board_div, 5, 5)
    sleep 0.9
    expect(board.reload.width).to have_text(50)
    expect(board.height).to have_text(50)

    # Don't allow to get out of the dropzone
    board_div.drag_by(100, 100)
    sleep 0.9
    board_div.drag_by(-100, -100)
    expect(page).to have_css('.board', count: 5)

    # double click for edit
    order_board = find("#board-#{with_order_board.id}")
    order_board.double_click
    expect(page).to have_css('.modal')
    within('.modal') do
      expect(page).to have_css('form')
      fill_in 'board_width', with: 200
      fill_in 'board_height', with: 150
      fill_in 'board_pos_x', with: 400
      fill_in 'board_pos_y', with: 100
      click_button 'Editar'
    end
    expect(page).to_not have_css('.modal')
    expect(page).to have_css('.board', count: 5)
    expect(with_order_board.reload.width).to have_text(200)
    expect(with_order_board.height).to have_text(150)
    expect(with_order_board.pos_x).to have_text(400)
    expect(with_order_board.pos_y).to have_text(100)

    # delete board
    board_div.double_click
    expect(page).to have_css('.modal')
    within('.modal') do
      click_link 'Borrar'
    end
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_css('.modal')
    expect(page).to have_css('.board', count: 4)

    # create a board
    click_link 'Crear Mesa'
    expect(page).to have_css('.modal')
    within('.modal') do
      fill_in 'board_number', with: 100
      fill_in 'board_width', with: 150
      fill_in 'board_height', with: 150
      fill_in 'board_pos_x', with: 100
      fill_in 'board_pos_y', with: 100
      click_button 'Crear'
    end
    expect(page).to have_css('.board', count: 5)
    new_board = find("#board-#{Board.last.id}")
    expect(new_board.native.style('transform')).to eq 'matrix(1, 0, 0, 1, 100, 100)'
  end

  def border_div_resize(board, right_by, down_by)
    x, y = border_point(board)
    page.driver.browser.action.move_to(board.native, x, y).click_and_hold
        .move_to(board.native, right_by, down_by).release.perform
  end

  # pick the borders
  def border_point(board)
    [board.native.size.width - 1, board.native.size.height - 1]
  end
end
