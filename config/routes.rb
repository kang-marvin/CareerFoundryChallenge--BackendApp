# rubcop:disable all

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/mentors/index',   to: "mentors#index"
      get '/mentors/show',    to: "mentors#show"
      post '/mentors/update', to: "mentors#update"

    end
  end

  get 'status', to: 'authentication#status'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
