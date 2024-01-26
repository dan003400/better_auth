# frozen_string_literal: true

BetterAuth::Engine.routes.draw do
  ## Sessions
  get '/new', to: 'sessions#new', as: 'new_session'

  ## Passwordless
  post '/create', to: 'sessions#create', as: 'create_session'
  get '/success', to: 'sessions#success', as: 'success_session'
  get '/confirm/:token', to: 'sessions#confirm', as: 'confirm_session'
  post '/destroy', to: 'sessions#destroy', as: 'destroy_session'

  ## Omniauth
  # get '/auth/:provider/callback', to: 'better_auth/sessions#oauth'
  # get '/auth/failure', to: redirect('new')
end
