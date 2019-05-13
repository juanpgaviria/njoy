require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /' do
    context 'nobody authenticated' do
      before { get '/' }
      it 'success' do
        expect(response.status).to eq 200
      end
    end

    context 'user authenticated' do
      let!(:user) { create(:user) }
      before do
        sign_in user
        get '/'
      end

      it 'redirect to companies' do
        expect(response.status).to eq 302
        expect(response).to redirect_to(companies_path)
      end
    end

    context 'company authenticated' do
      let!(:company) { create(:company) }
      before do
        sign_in company
        get '/'
      end

      it 'redirect to company' do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_employees_session_path)
      end
    end

    context 'employee authenticated' do
      let!(:company) { create(:company) }
      let!(:employee) { create(:employee, company: company, password: '1234') }

      before do
        sign_in company
        sign_in_employee
        get '/'
      end

      it 'redirect to company' do
        expect(response.status).to eq 302
        expect(response).to redirect_to(boards_path)
      end
    end
  end
end
