Rails.application.routes.draw do
  resources :schools do
    get 'gender'
    get 'ethnicity'
    get 'special'
  end

  resources :data do
  	get 'get_data'
  end

  root 'schools#index'
end
