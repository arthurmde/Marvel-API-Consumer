TestMarvelApi::Application.routes.draw do
  resources :characters, only: [:index, :show]
  resources :comics, only: [:index, :show]
end
