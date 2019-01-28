Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :products ,only: [:show, :create, :index] do

    resources :reviews, only: [:index]
  end

  resources :users, only: :create  do
    collection do
      post 'login'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :products ,only: [:show, :create, :index]
      post 'products/:id/upload_image', to: "products#upload_image"
    end
  end
end
