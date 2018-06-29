# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TermsOfService, type: :model do
  subject { create :terms_of_service }

  it { should have_db_column(:content) }
  it { should have_db_column(:version) }
  it { should have_db_column(:effective_at) }
  it { should have_many(:users).dependent(:nullify) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:version) }
  it { should validate_presence_of(:effective_at) }

  it { should validate_uniqueness_of(:version).case_insensitive }

  describe '.current' do
    before do
      Timecop.freeze Date.new(2017, 1, 20)
    end

    after do
      Timecop.return
    end

    subject { TermsOfService.current }

    context 'when no terms of service exist' do
      before do
        TermsOfService.destroy_all
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when terms of service are effective in the future' do
      let!(:future_tos) { create :terms_of_service, :in_the_future }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when several terms of service are effective in the past' do
      let!(:past_tos_1) { create :terms_of_service, effective_at: 1.month.ago }
      let!(:past_tos_2) { create :terms_of_service, effective_at: 2.months.ago }

      it 'returns current terms of service based on effective_at' do
        expect(subject).to eq(past_tos_1)
      end
    end

    context 'when terms of service apply today' do
      let!(:tos) { create :terms_of_service, effective_at: Time.zone.now }

      it 'returns these terms of service' do
        expect(subject).to eq(tos)
      end
    end
  end
end
