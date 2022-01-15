Rails.application.routes.draw do
  root 'pricing#index'

  post 'get_price', to: 'pricing#get_price'
end
