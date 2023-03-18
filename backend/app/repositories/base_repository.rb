# frozen_string_literal: true

class BaseRepository
  def initialize(user)
    @current_user = user
  end

  # Abstract method
  def scope; end

  protected

  attr_reader :current_user
end
