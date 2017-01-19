require 'rails_helper'

RSpec.describe 'Transaction filtering', :type => :request do

  before do
    user = FactoryGirl.create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    FactoryGirl.create(:currency, user: user)

    @category1 = FactoryGirl.create(:category, user: user, title: 'cat1')
    @category2 = FactoryGirl.create(:category, user: user, title: 'cat2')
    FactoryGirl.create_list(:transaction, 1, category: @category1, user: user, kind: 'debit', date: Date.parse('01-01-2016'))
    FactoryGirl.create_list(:transaction, 2, category: @category1, user: user, kind: 'debit', date: Date.parse('20-12-2016'))
    FactoryGirl.create_list(:transaction, 2, category: @category2, user: user, kind: 'credit', date: Date.parse('01-01-2016'))
    FactoryGirl.create_list(:transaction, 2, category: @category2, user: user, kind: 'credit', date: Date.parse('20-05-2016'))
  end

  describe 'filter by type' do

    it 'renders all transactions' do
      get '/api/transactions?kind='
      expect(JSON.parse(response.body)['transactions'].count).to be 7
    end

    it 'renders only debit transactions' do
      get '/api/transactions?kind=debit'
      expect(JSON.parse(response.body)['transactions'].count).to be 3
    end

    it 'renders only credit transactions' do
      get '/api/transactions?kind=credit'
      expect(JSON.parse(response.body)['transactions'].count).to be 4
    end
  end

  describe 'filter by date' do

    it 'renders transactions' do
      get '/api/transactions?date_from=01-05-2016'
      expect(JSON.parse(response.body)['transactions'].count).to be 4
    end

    it 'renders transactions' do
      get '/api/transactions?date_to=01-05-2016'
      expect(JSON.parse(response.body)['transactions'].count).to be 3
    end

    it 'renders transactions' do
      get '/api/transactions?date_from=01-05-2016&date_to=01-12-2016'
      expect(JSON.parse(response.body)['transactions'].count).to be 2
    end
  end

  describe 'filter by category' do

    it 'renders transactions' do
      get "/api/transactions?category_id=#{@category1.id}"
      expect(JSON.parse(response.body)['transactions'].count).to be 3
    end

    it 'renders transactions' do
      get "/api/transactions?category_id=#{@category2.id}"
      expect(JSON.parse(response.body)['transactions'].count).to be 4
    end
  end


end