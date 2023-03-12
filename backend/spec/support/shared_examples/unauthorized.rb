# typed: false
# frozen_string_literal: true

RSpec.shared_examples 'unauthorized' do |user|
  context 'when not authenticated' do
    it 'returns 401' do
      action

      expect(response).to have_http_status(:unauthorized)
    end

    context 'when logged but not confirmed' do
      api_sign_in(user)

      it 'returns 401' do
        action

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
