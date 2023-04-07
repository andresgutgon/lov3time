# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:gender) { 'woman' }
  let(:sexuality) { 'pansexual' }
  let(:gender_preference) { %w[woman man nonbinary] }
  let(:birthday) { Date.new(1980, 11, 4) }
  let(:model) do
    build(
      :person,
      gender:,
      gender_preference:,
      sexuality:,
      birthday:
    )
  end

  describe 'validations' do
    subject { model }

    before do
      Timecop.freeze(Time.zone.local(2023, 3, 25))
    end

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

    describe '#age' do
      it { is_expected.to be_valid }

      context 'when birthday is nil' do
        let(:birthday) { nil }

        it { is_expected.to be_valid }
      end

      context 'when person has 18 years' do
        let(:birthday) { Date.new(2005, 3, 25) }

        it { is_expected.to be_valid }
      end

      context 'when person has under 18 years' do
        let(:birthday) { Date.new(2005, 3, 26) }

        it 'shows and error' do
          is_expected.to be_invalid
          expect(model.errors.messages).to eq(
            birthday: ['Must be older than 18']
          )
        end
      end
    end
  end
end
