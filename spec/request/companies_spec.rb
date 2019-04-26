require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /companies' do
    context 'user no logged' do
      before { get '/companies' }

      it 'should redirect to login' do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user logged' do
      let!(:company_user) { create(:company, user: user) }
      let!(:company) { create(:company) }

      before do
        sign_in user
        get '/companies'
      end

      it 'should be success' do
        expect(assigns(:companies).count).to eq 1
        expect(response.status).to eq 200
      end
    end

    context 'Company logged' do
      let!(:company) { create(:company) }

      before do
        sign_in company
        get '/companies'
      end

      describe 'employee logged without permissions' do
        let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

        before { sign_in_employee }

        it 'should redirect' do
          expect(response.status).to eq 302
          expect(response).to redirect_to root_path
        end
      end

      describe 'employee logged with permissions' do
        let!(:employee) { create(:employee, company: company, password: '1234', role: :admin) }

        before { sign_in_employee }

        it 'should redirect' do
          expect(response.status).to eq 302
        end
      end
    end
    describe 'GET /companies/:id' do
      let!(:company) { create(:company, user: user) }

      context 'user and company no authenticated' do
        before { get "/companies/#{company.id}" }

        it 'redirect company login' do
          expect(response.status).to eq 302
          expect(response).to redirect_to new_company_session_path
        end
      end

      context 'user authenticated' do
        before do
          sign_in user
          get "/companies/#{company.id}"
        end

        it 'success' do
          expect(assigns(:company)).to eq company
          expect(response.status).to eq 200
        end
      end

      context 'company authenticated' do
        before do
          sign_in company
          get "/companies/#{company.id}"
        end

        it 'success' do
          expect(assigns(:company)).to eq company
          expect(response.status).to eq 200
        end
      end
    end
  end
end
