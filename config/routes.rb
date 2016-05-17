Rails.application.routes.draw do

  root to: 'stories#index'

  resources :stories, only: :index
  get 'stories/older' => 'stories#older'

end
