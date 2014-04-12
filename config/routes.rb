TestMarvelApi::Application.routes.draw do

  resources :characters, only: [:index, :show]
end
