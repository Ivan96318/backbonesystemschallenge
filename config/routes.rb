Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope module: 'api' do
    get '/api/zip_codes/:id', to: 'zip_codes#show', as: 'zip_codes'
  end
end
