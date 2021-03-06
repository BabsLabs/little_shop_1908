Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
  post "/items/:item_id/reviews", to: 'reviews#create'
  get "/items/:item_id/reviews/:id/edit", to: "reviews#edit"
  patch "/items/:item_id/reviews/:id", to: "reviews#update"
  delete "/items/:item_id/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#create"
  patch "/cart/:item_id/increment", to: "cart#increment"
  patch "/cart/:item_id/decrement", to: "cart#decrement"
  get "/cart", to: "cart#index"
  delete "/cart", to:"cart#empty"
  put "/cart/:item_id", to: "cart#remove"

  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  get "/orders/:id", to: 'orders#show'
end
