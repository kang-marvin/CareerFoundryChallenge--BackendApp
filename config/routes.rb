# rubcop:disable all

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      scope :users do
        # Student based paths
        scope :students do
          get '/index', to: "students#index"
          get '/show',  to: "students#show"

          post '/create_appointment',
               to: "students#create_appointment"
        end

      end

      get '/mentors/index',   to: "mentors#index"
      get '/mentors/show',    to: "mentors#show"
      post '/mentors/update', to: "mentors#update"

    end
  end

  get 'status', to: 'authentication#status'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
