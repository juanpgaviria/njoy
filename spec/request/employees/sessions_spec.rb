require 'rails_helper'

RSpec.describe 'Employees sessions', type: :request do
  describe 'company no logged' do
    before { get '/employees/sessions/new' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:companies) { create_list(:company, 9, user: company.user) }
    let!(:employee) { create(:employee, company: company, password: '1234') }

    before do
      sign_in company
    end

    context 'GET :new_employees_session' do
      before { get '/employees/sessions/new' }

      it 'success' do
        expect(response.status).to eq 200
      end
    end

    context 'POST :employees_session' do
      context 'valid attributes' do
        before { post '/employees/sessions', params: { password: '1234' } }

        it 'should create a session' do
          expect(response.status).to eq 302
          expect(response.cookies['employee_id']).to eq employee.id.to_s
          expect(assigns(:current_employee)).to eq employee
        end
      end

      context 'invalid attributes' do
        before { post '/employees/sessions', params: { password: '' } }

        it 'should render login form' do
          expect(response).to render_template :new
        end
      end
    end

    context 'DELETE :employees_session' do
      before do
        # in order to create a session before destroy it
        post '/employees/sessions', params: { password: '1234' }
        delete '/employees/sessions/destroy'
      end

      it 'should create a session' do
        expect(response.status).to eq 302
        expect(response.cookies['employee_id']).to be_nil
      end
    end
  end
end
