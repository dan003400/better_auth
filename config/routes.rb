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
  if BetterAuth.configuration.google_client_id && BetterAuth.configuration.google_client_secret
    get '/oauth/:provider/callback', to: 'sessions#oauth', as: 'oauth_callback'
    get '/oauth/failure', to: redirect('new'), as: 'oauth_failure'
  end
end
