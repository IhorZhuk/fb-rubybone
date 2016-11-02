Rails.application.routes.draw do

  scope "api" do 
    resources :transactions do
    collection do
    get :custom_action
    end
  end
  end
  
  root 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
