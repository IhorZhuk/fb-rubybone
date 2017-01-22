require 'rails_helper'

RSpec.describe 'Transaction filtering', :type => :request do

  before do
    user = FactoryGirl.create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    FactoryGirl.create(:currency, user: user)

    @category1 = FactoryGirl.create(:category, user: user, title: 'cat1')
    @category2 = FactoryGirl.create(:category, user: user, title: 'cat2')
    FactoryGirl.create_list(:transaction, 1, category: @category1, user: user, kind: 'debit', date: Date.parse('01-01-2016'), title: 'title1', note: 'note1', amount: 10)
    FactoryGirl.create_list(:transaction, 2, category: @category1, user: user, kind: 'debit', date: Date.parse('20-12-2016'), title: 'title2', note: 'note2', amount: 20.5)
    FactoryGirl.create_list(:transaction, 2, category: @category2, user: user, kind: 'credit', date: Date.parse('01-01-2016'), title: 'title foo', note: 'note bla', amount: 30)
    FactoryGirl.create_list(:transaction, 2, category: @category2, user: user, kind: 'credit', date: Date.parse('20-05-2016'), title: 'foo bar', note: 'bla param', amount: 40)
  end

  describe 'totals' do
    it 'all totals' do
      get '/api/transactions?kind='
      body = JSON.parse(response.body)
      expect(body['transactions'].count).to be 7
      expect(body['totals']['count']).to be 7
      expect(body['totals']['debit']).to be 51.0
      expect(body['totals']['credit']).to be 140.0
      expect(body['totals']['difference']).to be 89.0
    end

    it 'debits' do
      get '/api/transactions?kind=debit'
      body = JSON.parse(response.body)
      expect(body['transactions'].count).to be 3
      expect(body['totals']['count']).to be 3
      expect(body['totals']['debit']).to be 51.0
      expect(body['totals']['credit']).to be 0.0
      expect(body['totals']['difference']).to be -51.0
    end

    it 'credits' do
      get '/api/transactions?kind=credit'
      body = JSON.parse(response.body)
      expect(body['transactions'].count).to be 4
      expect(body['totals']['count']).to be 4
      expect(body['totals']['debit']).to be 0.0
      expect(body['totals']['credit']).to be 140.0
      expect(body['totals']['difference']).to be 140.0
    end
  end

  describe 'filter by kind' do
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

  it 'filter by title' do
    get "/api/transactions?title=title"
    expect(JSON.parse(response.body)['transactions'].count).to be 5

    get "/api/transactions?title=title1"
    expect(JSON.parse(response.body)['transactions'].count).to be 1

    get "/api/transactions?title=bar"
    expect(JSON.parse(response.body)['transactions'].count).to be 2

    get "/api/transactions?title=foo"
    expect(JSON.parse(response.body)['transactions'].count).to be 4
  end

  it 'filter by note' do
    get "/api/transactions?note=note"
    expect(JSON.parse(response.body)['transactions'].count).to be 5

    get "/api/transactions?note=note1"
    expect(JSON.parse(response.body)['transactions'].count).to be 1

    get "/api/transactions?note=param"
    expect(JSON.parse(response.body)['transactions'].count).to be 2

    get "/api/transactions?note=bla"
    expect(JSON.parse(response.body)['transactions'].count).to be 4
  end

  it 'filter by amount' do
    get "/api/transactions?amount=10"
    expect(JSON.parse(response.body)['transactions'].count).to be 1

    get "/api/transactions?amount=20.5"
    expect(JSON.parse(response.body)['transactions'].count).to be 2

    get "/api/transactions?amount=30"
    expect(JSON.parse(response.body)['transactions'].count).to be 2

    get "/api/transactions?amount=40"
    expect(JSON.parse(response.body)['transactions'].count).to be 2
  end

  it 'ordering' do
    get "/api/transactions?order=amount&direction=ASC"
    expect(JSON.parse(response.body)['transactions'][0]['amount']).to be 10.0

    get "/api/transactions?order=amount&direction=DESC"
    expect(JSON.parse(response.body)['transactions'][0]['amount']).to be 40.0

    get "/api/transactions?direction=DESC"
    expect(JSON.parse(response.body)['transactions'][0]['amount']).to be 10.0

    get "/api/transactions?order=title&direction=ASC"
    expect(JSON.parse(response.body)['transactions'][0]['title']).to eq 'foo bar'

    get "/api/transactions?order=title&direction=DESC"
    expect(JSON.parse(response.body)['transactions'][0]['title']).to eq 'title2'
  end

  it 'pagination' do
    get '/api/transactions'
    body = JSON.parse(response.body)
    expect(body['pagination']['per_page']).to be 20
    expect(body['pagination']['current_page']).to be 1
    expect(body['pagination']['total_pages']).to be 1
  end

end