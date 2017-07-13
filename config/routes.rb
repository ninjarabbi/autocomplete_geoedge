Rails.application.routes.draw do
  get '/autocomplete' => 'autocomplete#show'
  post '/add_names' => 'autocomplete#add_names'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
