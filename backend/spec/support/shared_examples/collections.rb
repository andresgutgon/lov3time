# typed: false
# frozen_string_literal: true

RSpec.shared_examples 'empty_collection' do |_user|
  it 'returns 0 items' do
    expect(json_body['data']).to be_empty
  end
end
