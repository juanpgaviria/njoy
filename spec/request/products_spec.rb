require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'company no logged' do
    before { get '/products' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:supplier) { create(:supplier, company: company) }
    let!(:category) { create(:category, company: company) }
    let!(:products) {
      create_list(:product, 10, supplier: supplier, category: category, company: company)
    }
    let!(:product) { products.last }

    before { sign_in company }

    describe 'employee logged without permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

      before { sign_in_employee }

      it 'should redirect' do
        expect(response.status).to eq 302
        expect(response).to redirect_to boards_path
      end
    end

    describe 'employee logged with permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :admin) }

      before { sign_in_employee }

      describe 'GET /products' do
        before { get '/products' }
        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:products).count).to eq 10
        end
      end

      describe 'GET /products/:id' do
        before { get "/products/#{product.id}" }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:product)).to eq product
        end
      end

      describe 'GET /products/new' do
        before { get '/products/new' }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'POST /products' do
        context 'valid request' do
          let!(:associations) { { category_id: category.id, supplier_id: supplier.id } }
          let!(:valid_attributes) { FactoryBot.attributes_for(:product) }
          before { post '/products', params: { product: valid_attributes.merge(associations) } }

          it 'success' do
            expect(assigns(:product).persisted?).to be_truthy
            expect(company.products.count).to eq 11
            expect(response.status).to eq 302
          end
        end

        context 'invalid request' do
          before { post '/products', params: { product: { name: 'name' } } }

          it 'fail' do
            expect(assigns(:product).persisted?).to be_falsy
            expect(company.products.count).to eq 10
            expect(response).to render_template(:new)
          end
        end
      end
      describe 'GET /products/:id/edit' do
        before { get "/products/#{product.id}/edit" }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'PUT /products/:id' do
        context 'valid attributes' do
          before { put "/products/#{product.id}", params: { product: { name: 'updated' } } }

          it 'success' do
            expect(product.reload.name).to eq 'updated'
            expect(response.status).to eq 302
          end
        end

        context 'invalid attributes' do
          before { put "/products/#{product.id}", params: { product: { name: '' } } }

          it 'fail' do
            expect(response.status).to eq 200
            expect(response).to render_template(:edit)
          end
        end
      end

      describe 'DELETE /products/:id' do
        before { delete "/products/#{product.id}" }

        it 'success' do
          expect(response.status).to eq 302
          expect(company.products.count).to eq 9
        end
      end
    end
  end
end
