# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Api::ExceptionHandler
    include Api::JsonApi

    before_action :logged_and_confirmed!

    private

    def logged_and_confirmed!
      raise Exceptions::Unauthorized unless user_signed_in?
    end

    def user_signed_in?
      api_user_signed_in? && current_user.confirmed?
    end

    # Syntax sugar because generated method is based
    # on route namespace. I don't like but it's what it is
    def current_user
      current_api_user
    end
  end
end
