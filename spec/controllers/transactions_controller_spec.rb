require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do

  describe 'GET #index' do

    before do
      user = FactoryGirl.create(:user)
      allow(controller).to(receive(:current_user).and_return(user))
      currency = FactoryGirl.create(:currency, user: user)
      category = FactoryGirl.create(:category, user: user)
      FactoryGirl.create_list(:transaction, 5, category: category, user: user)
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders json format' do
      get :index
      expect(response.header['Content-Type']).to include('application/json')
    end

    it 'renders all transactions' do
      get :index
      expect(JSON.parse(response.body)['transactions'].count).to be 5
    end
  end

end
