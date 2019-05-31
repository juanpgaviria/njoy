require 'rails_helper'

RSpec.describe 'Transaktions', type: :request do
  describe 'company no logged' do
    before { get '/transaktions' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:supplier) { create(:supplier, company: company) }
    let!(:category) { create(:category, company: company) }
    let!(:employee) { create(:employee, company: company) }
    let!(:product) {
      create(:product, company: company, supplier: supplier, category: category, quantity: 10)
    }

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
      let!(:transaktion) {
        create(:transaktion, company: company, employee: employee, product: product)
      }

      before { sign_in_employee }

      describe 'GET /transaktions' do
        before { get '/transaktions' }
        it 'success' do
          expect(response.status).to eq 200
        end
      end

      it 'returns a json object' do
        get '/transaktions.json', xhr: true, params: { 'columns[0][data]':
                                                      'name', 'columns[0][search][regex]': false }

        hash_response = nil
        expect {
          hash_response = JSON.parse(response.body).with_indifferent_access
        }.to_not raise_exception
        expect(hash_response[:recordsTotal]).to eq 1
      end

      describe 'GET /transaktions/:id' do
        before { get "/transaktions/#{transaktion.id}" }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:transaktion)).to eq transaktion
        end
      end

      describe 'GET /transaktions/new' do
        before { get '/transaktions/new' }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'POST /transaktions' do
        context 'valid request' do
          context 'deposit' do
            let!(:associations) {
              { company_id: company.id, employee_id: employee.id, product_id: product.id }
            }
            let!(:valid_attributes) { FactoryBot.attributes_for(:transaktion) }
            before {
              post '/transaktions', params: { transaktion: valid_attributes.merge(associations) }
            }

            it 'success' do
              expect(assigns(:transaktion).persisted?).to be_truthy
              expect(response.status).to eq 302
            end
          end

          context 'withdraw' do
            let!(:associations) {
              { company_id: company.id, employee_id: employee.id, product_id: product.id }
            }
            let!(:valid_attributes) { { quantity: 10, kind: :withdraw } }
            before {
              post '/transaktions', params: { transaktion: valid_attributes.merge(associations) }
            }

            it 'success' do
              expect(assigns(:transaktion).persisted?).to be_truthy
              expect(response.status).to eq 302
            end
          end
        end

        context 'invalid request' do
          context 'withdraw without stock' do
            let!(:associations) {
              { company_id: company.id, employee_id: employee.id, product_id: product.id }
            }
            let!(:valid_attributes) { { quantity: 100, kind: :withdraw } }
            before {
              post '/transaktions', params: { transaktion: valid_attributes.merge(associations) }
            }

            it 'success' do
              expect(assigns(:transaktion).persisted?).to be_falsy
              expect(assigns(:transaktion).errors.empty?).to_not be_truthy
              expect(response).to render_template(:new)
            end
          end

          context 'bad request' do
            before { post '/transaktions', params: { transaktion: { name: 'name' } } }

            it 'fail' do
              expect(assigns(:transaktion).persisted?).to be_falsy
              expect(response).to render_template(:new)
            end
          end
        end
      end
    end
  end
end
