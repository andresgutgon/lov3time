# frozen_string_literal: true

Rails.application.routes.draw do
  # Mobile and web apps use this API
  namespace :api do
    mount_devise_token_auth_for(
      'User',
      at: 'auth',
      skip: %i[omniauth_callbacks passwords],
      controllers: {
        registrations: 'api/auth_overrides/registrations'
      }
    )
  end

  mount(
    LetterOpenerWeb::Engine,
    at: '/letter_opener'
  ) if Rails.env.development?
end
