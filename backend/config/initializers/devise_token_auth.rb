# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  # I'll try this because is the more secure way
  # If it doesn't work I'll disable it
  config.change_headers_on_each_request = true

  # FIXME: Reduce this if I can validate the idea.
  # During BETA do not bother users with re-authenticate
  # After BETA (lol) low down to 1.month
  config.token_lifespan = 6.months

  # After BETA set this to `true` to invalidate old
  # tokens when password is changed
  config.remove_tokens_after_password_reset = false

  # Faster tests with a lower token cost generation.
  config.token_cost = Rails.env.test? ? 4 : 10
  config.max_number_of_devices = 3
  config.omniauth_prefix = '/api/omniauth'
  config.check_current_password_before_update = :password
  config.send_confirmation_email = true

  # Pure OCD. I prefer underscores
  config.headers_names = {
    'access-token': 'access_token',
    client: 'client',
    expiry: 'expiry',
    uid: 'uid',
    'token-type': 'token_type',
    authorization: 'authorization'
  }
end
