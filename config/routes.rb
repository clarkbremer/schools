Rails.application.routes.draw do
  resources :schools do
    get 'gender'
    get 'ethnicity'
    get 'special'
  end

  root 'schools#index'
end
