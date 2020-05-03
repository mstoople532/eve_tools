Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :fit_auditor, only: [:index]
  post :fit_auditor, to: 'fit_auditor#audit'
end
