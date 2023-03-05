# frozen_string_literal: true

require 'rails_helper'

describe '#confirmation_email', type: :request do
  let(:user) { create(:user) }
  # Probably change when implement mobile
  let(:redirect_url) { Faker::Internet.url }

  describe 're-send confirmation' do
    let(:email) { user.email }
    let(:params) do
      { email:, redirect_url: }
    end
    let(:action) { post '/api/auth/confirmation', params: }

    before { action }

    it 'successfully signup' do
      expect(response).to have_http_status(:success)
    end

    it 'return success message' do
      expect(response.body).to include_json(
        success: true,
        message: I18n.t('devise_token_auth.confirmations.sended_paranoid')
      )
    end

    context 'when user does not exists' do
      let(:email) { 'meloinvento@porquequiero.com' }

      it 'does not indicate user does not exists' do
        expect(response.body).to include_json(
          success: true,
          message: I18n.t('devise_token_auth.confirmations.sended_paranoid')
        )
      end
    end
  end

  describe 'confirm' do
    def token_and_client_config_from(body)
      token         =
      client_config = body.match(/config=([^&]*)&/)[1]
      [token, client_config]
    end
    let(:confirmation_token) do
      user.send_confirmation_instructions(redirect_url:)
      mail = ActionMailer::Base.deliveries.last
      mail.body.match(/confirmation_token=([^&]*)&/)[1]
    end
    let(:token_params) do
      %w[access-token client client_id config expiry token uid]
    end
    let(:params) {{ redirect_url:, confirmation_token: }}
    let(:action) { get '/api/auth/confirmation', params: }

    it 'redirect to redirect_url' do
      expect(action).to redirect_to("#{redirect_url}?account_confirmation_success=true")
    end

    it 'user is not confirmed' do
      action
      expect(user.confirmed?).to be_falsey
    end
    it 'is confirmed' do
      action
      expect(user.reload.confirmed?).to be_truthy
    end
  end
end
