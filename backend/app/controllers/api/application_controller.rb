# frozen_string_literal: true
module Api
  class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken

    respond_to :json
  end
end
