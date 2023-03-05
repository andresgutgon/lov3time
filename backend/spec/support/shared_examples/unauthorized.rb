# typed: false
# frozen_string_literal: true

RSpec.shared_examples 'unauthorized' do
  context 'when not authenticated' do
    it 'returns 401' do
      action

      expect(response).to have_http_status(:unauthorized)
    end
  end
end

RSpec.shared_examples 'staff_only' do
  context 'when not authorized' do
    before { sign_in user }

    it 'returns 403' do
      action

      expect(response).to have_http_status(:forbidden)
    end
  end
end
