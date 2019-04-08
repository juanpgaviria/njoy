require 'rails_helper'

RSpec.describe 'Suppliers', type: :request do

  describe 'company no logged' do
    before { get '/suppliers' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:suppliers) { create_list(:supplier, 10, company: company) }
    let!(:supplier) { suppliers.last }

    before { sign_in company }

    describe 'GET /suppliers' do

      before { get '/suppliers' }
      it 'success' do
        expect(response.status).to eq 200
        expect(assigns(:suppliers).count).to eq 10
      end
    end

    describe 'GET /suppliers/:id' do

      before { get "/suppliers/#{supplier.id}" }

      it 'success' do
        expect(response.status).to eq 200
        expect(assigns(:supplier)).to eq supplier
      end
    end

    describe 'GET /suppliers/new' do
      before { get '/suppliers/new' }

      it 'success' do
        expect(response.status).to eq 200
      end
    end

    describe 'POST /suppliers' do
      context 'valid request' do
        let!(:valid_attributes) { FactoryBot.attributes_for(:supplier) }
        before { post '/suppliers', params: { supplier: valid_attributes } }

        it 'success' do
          expect(assigns(:supplier).persisted?).to be_truthy
          expect(company.suppliers.count).to eq 11
          expect(response.status).to eq 302
        end
      end

      context 'invalid request' do
        before { post '/suppliers', params: { supplier: { name: 'name' } } }

        it 'fail' do
          expect(assigns(:supplier).persisted?).to be_falsy
          expect(company.suppliers.count).to eq 10
          expect(response).to render_template(:new)
        end

      end
    end
    describe 'GET /suppliers/:id/edit' do
      before { get "/suppliers/#{supplier.id}/edit" }

      it 'success' do
        expect(response.status).to eq 200
      end
    end

    describe 'PUT /suppliers/:id' do
      context 'valid attributes' do
        before { put "/suppliers/#{supplier.id}", params: { supplier: { name: 'updated' } } }

        it 'success' do
          expect(supplier.reload.name).to eq 'updated'
          expect(response.status).to eq 302
        end
      end

      context 'invalid attributes' do
        before { put "/suppliers/#{supplier.id}", params: { supplier: { name: '' } } }

        it 'fail' do
          expect(response.status).to eq 200
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE /suppliers/:id' do
      before { delete "/suppliers/#{supplier.id}" }

      it 'success' do
        expect(response.status).to eq 302
        expect(company.suppliers.count).to eq 9
      end
    end
  end
end
