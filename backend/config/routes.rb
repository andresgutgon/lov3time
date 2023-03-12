# frozen_string_literal: true

Rails.application.routes.draw do
  get 'people/index'
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

    # All the love goes here
    resources :people, only: %i[index]
  end

  if Rails.env.development?
    mount(
      LetterOpenerWeb::Engine,
      at: '/letter_opener'
    )
  end
end
