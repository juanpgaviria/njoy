require 'rails_helper'

RSpec.describe 'Attendances', type: :request do
  describe 'company no logged' do
    before { get '/employees' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }
    let!(:employee) { create(:employee, company: company, password: '1234') }

    before { sign_in company }

    describe 'employee logged' do
      let!(:employee) { create(:employee, company: company, password: '1234', role: :chef) }

      before { sign_in_employee }

      it 'should redirect' do
        employee.reload
        expect(response.status).to eq 302
        expect(employee.attendances.count).to eq 1
        expect(employee.status).to eq 'active'
        expect(response).to redirect_to boards_path
      end

      describe 'Close turn' do
        before { delete "/attendances/#{employee.id}" }

        it 'success' do
          expect(response.status).to eq 302
          expect(employee.attendances.count).to eq 1
          expect(response).to redirect_to new_employees_session_path
        end
      end
    end
  end
end
