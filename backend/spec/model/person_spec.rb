# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:gender) { 'woman' }
  let(:sexuality) { 'pansexual' }
  let(:gender_preference) { %w[woman man nonbinary] }
  let(:current_day) { Time.zone.local(2023, 3, 25) }
  let(:birthday) { Date.new(1980, 11, 4) }
  let(:birthday_setup_at) { current_day.change(hour: 18, min: 30, sec: 00 )}
  let(:model) do
    build(
      :person,
      gender:,
      gender_preference:,
      sexuality:,
      birthday:,
      birthday_setup_at:
    )
  end

  describe 'validations' do
    subject { model }

    before do
      Timecop.freeze(current_day)
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

    describe 'age validation' do
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

    describe '#birthday inmutable'  do
      let(:birthday) { Date.new(1980, 11, 5) }

      it { is_expected.to be_valid }

      context 'when birthday_setup_at is nil' do
        let(:birthday_setup_at) { nil }

        it { is_expected.to be_valid }
      end

      context 'when birthday_setup_at is after two weeks' do
        let(:time_in_future) do
          birthday_setup_at + 2.weeks
        end

        let(:today) { time_in_future }

        before { Timecop.travel(today) }

        it 'shows error' do
          is_expected.to be_invalid
          expect(model.errors.messages).to eq(
            birthday: ["You can't change your birthday"]
          )
        end

        context 'when is one hour before limit' do
          let(:today) { time_in_future - 1.hours }

          it { is_expected.to be_valid }
        end

        context 'when is one hour afte limit' do
          let(:today) { time_in_future + 1.hours }

          it { is_expected.to be_invalid }
        end
      end
    end
  end
end
