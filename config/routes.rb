Rails.application.routes.draw do

  resources :stories, only: :index
  get 'stories/older' => 'stories#older'

end
