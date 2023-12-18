Rails.application.routes.draw do
  resources :urls, only: [:create]
  get '/urls/:short_url', to: 'urls#show'
  get '/urls/:short_url/stats', to: 'urls#stats'
end
