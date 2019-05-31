require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'company not logged' do
    before { get '/categories' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:categories) { create_list(:category, 10, company: company) }
    let!(:category) { categories.last }

    before { sign_in company }

    describe 'employee not logged' do
      before { get '/categories' }

      it 'should redirect' do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_employees_session_path)
      end
    end

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

      describe 'GET /categories' do
        before { get '/categories' }
        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:categories).count).to eq 10
        end
      end

      it 'returns a json object' do
        get '/categories.json', xhr: true, params: { 'columns[0][data]':
                                                      'name', 'columns[0][search][regex]': false }

        hash_response = nil
        expect {
          hash_response = JSON.parse(response.body).with_indifferent_access
        }.to_not raise_exception
        expect(hash_response[:recordsTotal]).to eq 10
      end

      describe 'GET /categories/:id' do
        before { get "/categories/#{category.id}" }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:category)).to eq category
        end
      end

      describe 'GET /categories/new' do
        before { get '/categories/new' }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'POST /category' do
        context 'valid request' do
          let!(:valid_attributes) { FactoryBot.attributes_for(:category) }
          before { post '/categories', params: { category: valid_attributes } }

          it 'success' do
            expect(assigns(:category).persisted?).to be_truthy
            expect(company.categories.count).to eq 11
            expect(response.status).to eq 302
          end
        end

        context 'invalid request' do
          before { post '/categories', params: { category: { name: 'name' } } }

          it 'fail' do
            expect(assigns(:category).persisted?).to be_falsy
            expect(company.categories.count).to eq 10
            expect(response).to render_template(:new)
          end
        end
      end

      describe 'GET /categories/:id/edit' do
        before { get "/categories/#{category.id}/edit" }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'PUT /categories/:id' do
        context 'valid attributes' do
          before { put "/categories/#{category.id}", params: { category: { name: 'updated' } } }

          it 'success' do
            expect(category.reload.name).to eq 'updated'
            expect(response.status).to eq 302
          end
        end

        context 'invalid attributes' do
          before { put "/categories/#{category.id}", params: { category: { name: '' } } }

          it 'fail' do
            expect(response.status).to eq 200
            expect(response).to render_template(:edit)
          end
        end
      end

      describe 'DELETE /categories/:id' do
        before { delete "/categories/#{category.id}" }

        it 'success' do
          expect(response.status).to eq 302
          expect(company.categories.count).to eq 9
        end
      end
    end
  end
end
