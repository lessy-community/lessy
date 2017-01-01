require 'rails_helper'
require 'base64'

RSpec.describe JsonWebToken do
  describe '.encode' do
    let(:token) { described_class.encode({ data: 'test' }, 1.day.from_now) }

    it 'returns a token containing periods' do
      expect(token).to include('.')
    end

    it 'returns a token where each part is a valid base64-encoded value' do
      token.split('.').each do |part|
        expect { Base64.urlsafe_decode64(part) }.not_to raise_error
      end
    end
  end

  describe '.decode' do
    let(:decoded_token) { described_class.decode(token) }

    context 'when expiration is in the future' do
      let(:token) { described_class.encode({ data: 'test' }, 1.day.from_now) }

      it 'returns a decoded token with passed data' do
        expect(decoded_token[:data]).to eq('test')
      end
    end

    context 'when expiration is in the past' do
      let(:token) { described_class.encode({ data: 'test' }, 1.day.ago) }

      it 'returns nil' do
        expect(decoded_token).to be_nil
      end
    end

    context 'when token is nil' do
      let(:token) { nil }

      it 'returns nil' do
        expect(decoded_token).to be_nil
      end
    end
  end
end
