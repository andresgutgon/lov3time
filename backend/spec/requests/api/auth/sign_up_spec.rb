# frozen_string_literal: true

require 'rails_helper'

describe '#sign_up', type: :request do
  let(:is_confirmed) { true }
  let!(:user) { create(:user, :confirmed, is_confirmed:) }
  let(:email) { Faker::Internet.email }
  let(:params) do
    {
      email:,
      password: 'papapa44',
      password_confirmation: 'papapa44',
      confirm_success_url: Faker::Internet.url,
      unpermitted_param: '(x_x)'
    }
  end
  let(:action) { post '/api/auth', params: }

  it 'successfully signup' do
    action
    expect(response).to have_http_status(:success)
  end

  it 'sent a confirmation email' do
    expect { action }.to change(
      ActionMailer::Base.deliveries, :count
    )
  end

  it 'returns the token' do
    action
    expect(response.body).to include_json(
      status: 'success',
      data: {
        id: User.last.id,
        uid: email,
        email:,
        allow_password_change: false
      }
    )
  end

  context '#PUT /api/auth' do
    let(:params) do
      { email: 'change@email.com'}
    end
    api_sign_in(:user)
    let(:action) { put '/api/auth', params: }

    it 'returns success' do
      action
      expect(response).to have_http_status(:success)
    end

    it 'does not update an existing user' do
      action
      expect(user.reload.unconfirmed_email).to be_nil
    end

    context 'when #PATCH' do
      let(:action) { patch '/api/auth', params: }

      it 'does not update an existing user' do
        action
        expect(user.reload.unconfirmed_email).to be_nil
      end
    end
  end

  context '#DELETE /api/auth' do
    api_sign_in(:user)
    let(:action) { delete '/api/auth' }

    it 'does not delete existing user' do
      expect { action }.not_to change { User.count }
    end
  end
end
