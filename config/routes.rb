Rails.application.routes.draw do

  scope "api" do 
    resources :transactions, 
              :categories, 
              :users, 
              :password_resets, 
              :currencies
  end

  root 'main#index'

  get '/api/totals' => 'totals#index'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
