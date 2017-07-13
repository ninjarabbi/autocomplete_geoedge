Rails.application.routes.draw do
  get '/autocomplete' => 'autocomplete#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
