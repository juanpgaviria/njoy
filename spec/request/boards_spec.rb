require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  describe 'company no logged' do
    before { get '/boards' }

    it 'should redirect' do
      expect(response.status).to eq 302
      expect(response).to redirect_to(new_company_session_path)
    end
  end

  describe 'company logged' do
    let!(:company) { create(:company) }

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
      let!(:boards) { create_list(:board, 10, company: company) }
      let!(:board) { boards.last }

      before { sign_in_employee }

      describe 'GET /boards' do
        before { get '/boards' }
        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:boards).count).to eq 10
        end
      end

      describe 'GET /boards/positions' do
        before { get '/boards/positions' }
        it 'success' do
          expect(response.status).to eq 200
          expect(assigns(:boards).count).to eq 10
        end
      end

      describe 'GET /boards/new' do
        before { get '/boards/new', xhr: true }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'POST /board' do
        context 'valid request' do
          let!(:valid_attributes) { FactoryBot.attributes_for(:board) }
          before { post '/boards', xhr: true, params: { board: valid_attributes } }

          it 'success' do
            expect(assigns(:board).persisted?).to be_truthy
            expect(company.boards.count).to eq 11
            expect(response.status).to eq 200
          end
        end

        context 'invalid request' do
          before { post '/boards', xhr: true, params: { board: { pos_x: 10 } } }

          it 'fail' do
            expect(assigns(:board).persisted?).to be_falsy
            expect(company.boards.count).to eq 10
            expect(response.status).to eq 200
          end
        end
      end

      describe 'GET /boards/:id/edit' do
        before { get "/boards/#{board.id}/edit", xhr: true }

        it 'success' do
          expect(response.status).to eq 200
        end
      end

      describe 'PUT /boards/:id' do
        context 'valid attributes' do
          before { put "/boards/#{board.id}", xhr: true, params: { board: { number: 10 } } }

          it 'success' do
            expect(board.reload.number).to eq 10
            expect(response.status).to eq 200
          end
        end

        context 'invalid attributes' do
          before { put "/boards/#{board.id}", xhr: true, params: { board: { pos_x: 10 } } }

          it 'fail' do
            expect(response.status).to eq 200
          end
        end
      end

      describe 'DELETE /boards/:id' do
        before { delete "/boards/#{board.id}", xhr: true }

        it 'success' do
          expect(response.status).to eq 200
          expect(company.boards.count).to eq 9
        end
      end
    end
  end
end
