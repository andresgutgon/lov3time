# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:gender) { 'woman' }
  let(:sexuality) { 'pansexual' }
  let(:gender_preference) { %w[woman man nonbinary] }
  let(:model) do
    build(
      :person,
      gender:,
      gender_preference:,
      sexuality:
    )
  end

  describe 'validations' do
    subject { model }

    describe '#gender' do
      it { is_expected.to be_valid }

      context 'when not-recognized' do
        it 'does not allow not valid gender' do
          model.gender = 'foobar'
          is_expected.to be_invalid
        end
      end
    end

    describe '#gender_preference' do
      it { is_expected.to be_valid }

      context 'when not-recognized' do
        it 'does not allow not valid gender' do
          model.gender_preference = %w[foobar]
          is_expected.to be_invalid
        end
      end
    end

    describe '#sexuality' do
      it { is_expected.to be_valid }

      context 'when not-recognized' do
        it 'does not allow not valid term' do
          model.sexuality = 'non-existing-term'
          is_expected.to be_invalid
        end
      end
    end
  end
end
