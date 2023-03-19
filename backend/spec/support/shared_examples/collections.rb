# typed: false
# frozen_string_literal: true

RSpec.shared_examples 'empty_collection' do
  it 'returns 0 items' do
    expect(json_body['data']).to be_empty
  end
end

RSpec.shared_examples 'collection_with_one' do
  it 'returns one item' do
    expect(json_body['data'].size).to be(1)
  end
end
