# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Not used because by default `ActionController::API`
  # Does NOT includes CSRF token (aka protect_from_forgery)
  # Enable this if we switch from API only to full rails
  # protect_from_forgery with: :exception
end
