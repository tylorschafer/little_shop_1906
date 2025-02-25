Rails.application.routes.draw do

  get "/", to: "welcome#index"

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: 'reviews#new'
  post "/items/:id", to: 'reviews#create'
  get "/items/:item_id/:review_id/edit", to: 'reviews#edit'
  patch "/items/:item_id/:review_id", to: 'reviews#update'
  delete "/items/:item_id/:review_id", to: 'reviews#destroy'

  get '/cart', to: 'cart#show'
  patch "/cart/:item_id", to: 'cart#update'
  patch "/cart/:item_id/add", to: 'cart#update'
  patch "/cart/:item_id/remove", to: 'cart#update'
  delete "/cart/:item_id", to: 'cart#delete'
  delete '/cart', to: 'cart#destroy'

  get '/orders', to: 'orders#index'
  get '/orders/:id', to: 'orders#show'
  post '/orders', to: 'orders#create'
end
