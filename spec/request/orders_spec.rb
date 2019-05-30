require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let!(:company) { create(:company) }
  let!(:board) { create(:board, company: company, status: :free) }
  let!(:categories) { create_list(:category, 5, company: company) }
  let!(:category) { categories.last }
  let!(:menu) { create(:menu, category: category, company: company) }

  before { sign_in company }

  describe 'employee logged without permissions' do
    let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

    before { sign_in_employee }

    it 'should redirect' do
      get "/boards/#{board.id}/orders/new"
      expect(response.status).to eq 302
      expect(response).to redirect_to boards_path
    end
  end

  describe 'employee logged with permissions' do
    let!(:employee) { create(:employee, company: company, password: '1234', role: :waiter) }

    before { sign_in_employee }

    describe 'GET /boards/:board_id/orders/new' do
      it 'success' do
        get "/boards/#{board.id}/orders/new"
        expect(assigns(:order).persisted?).to be_falsy
        expect(assigns(:categories).count).to eq 1
      end
    end

    describe 'POST /boards/:board_id/orders/' do
      let!(:menu) { create(:menu, company: company, category: categories.first) }
      let!(:order_attributes) { FactoryBot.attributes_for(:order, company: company, board: board) }
      let!(:order_item_attributes) { FactoryBot.attributes_for(:order_item, menu_id: menu.id) }
      let!(:valid_attributes) {
        order_attributes.merge(order_items_attributes: [order_item_attributes])
      }
      it 'success' do
        post "/boards/#{board.id}/orders", params: { order: valid_attributes }
        expect(assigns(:order).persisted?).to be_truthy
        expect(assigns(:order).order_items.count).to eq 1
        expect(response.status).to eq 302
      end

      it 'fail' do
        board.with_order!
        post "/boards/#{board.id}/orders", params: { order: order_attributes }
        expect(assigns(:order).persisted?).to be_falsy
        expect(response.status).to eq 302
        error = assigns(:order).errors.full_messages.first
        expect(error).to eq 'Board bussy La mesa no esta disponible'
      end
    end

    describe 'GET /boards/:board_id/orders/:id/edit' do
      let!(:order) { create(:order, company: company, board: board) }
      it 'success' do
        get "/boards/#{board.id}/orders/#{order.id}/edit"
        expect(assigns(:order).persisted?).to be_truthy
        expect(assigns(:categories).count).to eq 1
      end
    end

    describe 'PUT /boards/:board_id/orders/:id/edit' do
      let!(:order) { create(:order, company: company, board: board) }
      let!(:order_item_attributes) { FactoryBot.attributes_for(:order_item, menu_id: menu.id) }
      let!(:valid_attributes) { { order_items_attributes: [order_item_attributes] } }
      it 'success' do
        put "/boards/#{board.id}/orders/#{order.id}", params: { order: valid_attributes }
        expect(assigns(:order).persisted?).to be_truthy
        expect(assigns(:order).order_items.count).to eq 1
        expect(response.status).to eq 302
      end
    end
  end
end
