# rubcop:disable all

Rails.application.routes.draw do

  scope :api do
    scope :v1 do
      # Add more routes...
    end
  end

  get 'status', to: 'authentication#status'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
