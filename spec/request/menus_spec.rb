require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'company no logged' do
    before { get '/menus' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:supplier) { create(:supplier, company: company) }
    let!(:category) { create(:category, company: company) }
    let!(:product) { create(:product, supplier: supplier, category: category, company: company) }
    let!(:menus) { create_list(:menu, 10, company: company) }
    let!(:menu) { menus.last }

    before { sign_in company }

    describe 'employee logged without permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

      before { sign_in_employee }

      it 'should redirect' do
        get '/menus'
        expect(response.status).to eq 302
        expect(response).to redirect_to boards_path
      end
    end

    describe 'employee logged with permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :admin) }

      before { sign_in_employee }

      describe 'GET /menus' do
        it 'success' do
          get '/menus'
          expect(response.status).to eq 200
          expect(assigns(:menus).count).to eq 10
        end

        it 'returns a json object' do
          get '/menus.json', xhr: true, params: { 'columns[0][data]': 'name',
                                                  'columns[0][search][regex]': false }

          hash_response = nil
          expect {
            hash_response = JSON.parse(response.body).with_indifferent_access
          }.to_not raise_exception
          expect(hash_response[:recordsTotal]).to eq 10
        end
      end

      describe 'GET /menus/:id' do
        before { get "/menus/#{menu.id}" }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:menu)).to eq menu
        end
      end

      describe 'GET /menus/new' do
        before { get '/menus/new' }

        it 'success' do
          expect(assigns(:products).count).to eq 1
          expect(assigns(:categories).count).to eq 1
          expect(assigns(:menu).persisted?).to be_falsy
          expect(assigns(:menu_item).persisted?).to be_falsy
          expect(response.status).to eq 200
        end
      end

      describe 'POST /menus' do
        context 'valid request' do
          let!(:menu_attr) { FactoryBot.attributes_for(:menu, category_id: category.id) }
          let!(:menu_item_attr) { FactoryBot.attributes_for(:menu_item, product_id: product.id) }
          let!(:valid_attributes) {
            menu_attr.merge(menu_items_attributes: [menu_item_attr])
          }
          before { post '/menus', params: { menu: valid_attributes } }

          it 'success' do
            expect(assigns(:menu).persisted?).to be_truthy
            expect(company.menus.count).to eq 11
            expect(assigns(:menu).products.count).to eq 1
            expect(assigns(:menu).menu_items.count).to eq 1
            expect(response.status).to eq 302
          end
        end

        context 'invalid request' do
          before { post '/menus', params: { menu: { name: 'name' } } }

          it 'fail' do
            expect(assigns(:menu).persisted?).to be_falsy
            expect(company.menus.count).to eq 10
            expect(response).to render_template(:new)
          end
        end
      end
      describe 'GET /menus/:id/edit' do
        before { get "/menus/#{menu.id}/edit" }

        it 'success' do
          expect(assigns(:products).count).to eq 1
          expect(assigns(:categories).count).to eq 1
          expect(response.status).to eq 200
        end
      end

      describe 'PUT /menus/:id' do
        context 'valid attributes' do
          let!(:valid_attributes) {
            { name: 'updated',
              menu_items_attributes: [{ id: menu.menu_items.first.id, quantity: 1 }] }
          }
          before { put "/menus/#{menu.id}", params: { menu: valid_attributes } }

          it 'success' do
            expect(menu.reload.name).to eq 'updated'
            expect(menu.menu_items.first.quantity).to eq 1
            expect(response.status).to eq 302
          end
        end

        context 'invalid attributes' do
          before { put "/menus/#{menu.id}", params: { menu: { name: '' } } }

          it 'fail' do
            expect(response.status).to eq 200
            expect(response).to render_template(:edit)
          end
        end
      end

      describe 'DELETE /menus/:id' do
        before { delete "/menus/#{menu.id}" }

        it 'success' do
          expect(response.status).to eq 302
          expect(company.menus.count).to eq 9
        end
      end
    end
  end
end
