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

          post '/update_appointment',
               to: "students#update_appointment"

          delete '/delete_appointment',
                to: "students#delete_appointment"
        end

        # Mentor based paths
        scope :mentors do
          get '/index', to: "mentors#index"
          get '/show',  to: "mentors#show"

          post '/update_appointment',
               to: "mentors#update_appointment"
        end
      end

    end
  end

  get 'status', to: 'authentication#status'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
