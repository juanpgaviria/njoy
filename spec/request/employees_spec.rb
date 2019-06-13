require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe 'company no logged' do
    before { get '/employees' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:employees) { create_list(:employee, 9, company: company) }
    let!(:employee) { create(:employee, company: company, password: '1234') }

    before { sign_in company }

    describe 'employee logged without permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

      before { sign_in_employee }

      it 'should redirect' do
        employee.reload
        expect(response.status).to eq 302
        expect(response).to redirect_to boards_path
        expect(employee.attendances.count).to eq 1
        expect(employee.status).to eq 'active'
      end
    end

    describe 'employee logged with permissions' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :admin) }

      before { sign_in_employee }

      describe 'GET employees' do
        before { get '/employees' }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:employees).count).to eq 10
        end
      end

      it 'returns a json object' do
        get '/employees.json', xhr: true, params: { 'columns[0][data]':
                                                      'name', 'columns[0][search][regex]': false }

        hash_response = nil
        expect {
          hash_response = JSON.parse(response.body).with_indifferent_access
        }.to_not raise_exception
        expect(hash_response[:recordsTotal]).to eq 10
      end

      describe 'GET employee' do
        before { get "/employees/#{employee.id}" }

        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:employee)).to eq employee
        end
      end

      describe 'GET /employees/new' do
        before { get '/employees/new' }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'POST /employee' do
        context 'valid request' do
          let!(:valid_attributes) { FactoryBot.attributes_for(:employee) }
          before { post '/employees', params: { employee: valid_attributes } }

          it 'success' do
            expect(assigns(:employee).persisted?).to be_truthy
            expect(company.employees.count).to eq 11
            expect(response.status).to eq 302
          end
        end

        context 'invalid request' do
          before { post '/employees', params: { employee: { name: 'name' } } }

          it 'fail' do
            expect(assigns(:employee).persisted?).to be_falsy
            expect(company.employees.count).to eq 10
            expect(response).to render_template(:new)
          end
        end
      end
      describe 'GET /employees/:id/edit' do
        before { get "/employees/#{employee.id}/edit" }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'PUT /employees/:id' do
        context 'valid attributes' do
          before { put "/employees/#{employee.id}", params: { employee: { names: 'updated' } } }

          it 'success' do
            expect(employee.reload.names).to eq 'updated'
            expect(response.status).to eq 302
          end
        end

        context 'invalid attributes' do
          before { put "/employees/#{employee.id}", params: { employee: { names: '' } } }

          it 'fail' do
            expect(response.status).to eq 200
            expect(response).to render_template(:edit)
          end
        end

        context 'archive employee' do
          before { put "/employees/#{employee.id}", params: { employee: { status: :archived } } }

          it 'success' do
            employee.reload
            expect(response.status).to eq 302
            expect(employee.status).to eq 'archived'
            expect(response).to redirect_to employee_path(employee)
          end
        end

        context 'unarchive employee' do
          before { put "/employees/#{employee.id}", params: { employee: { status: :inactive } } }

          it 'success' do
            employee.reload
            expect(response.status).to eq 302
            expect(employee.status).to eq 'inactive'
            expect(response).to redirect_to employee_path(employee)
          end
        end
      end

      describe 'DELETE /employees/:id' do
        before { delete "/employees/#{employee.id}" }

        it 'success' do
          expect(response.status).to eq 302
          expect(company.employees.count).to eq 9
        end
      end
    end
  end
end
