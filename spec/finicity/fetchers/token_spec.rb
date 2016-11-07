require 'spec_helper'

describe Finicity::Fetchers::Token do
  let(:response) { Hashie::Mash.new(body: nil) }
  let(:redis) { { 'finicity-token-expires-at' => expires_at, 'finicity-token' => token } }
  let(:expires_at) { nil }
  let(:token) { nil }

  before do
    allow(Redis).to receive(:new).and_return(redis)
    allow(described_class).to receive(:request).and_return(response)
  end

  describe '.get' do
    subject { described_class.get }

    before do
      allow(described_class).to receive(:refresh)
      subject
    end

    context 'token-expires-at not present' do
      it { expect(described_class).to have_received(:refresh) }
    end

    context 'token-expires-at in the past' do
      let(:expires_at) { 2.hours.ago.to_s }

      it { expect(described_class).to have_received(:refresh) }
    end

    context 'token-expires-at in the future' do
      let(:expires_at) { 2.hours.from_now.to_s }
      let(:token) { 'token123bvr' }

      it { expect(subject).to eq('token123bvr') }
      it { expect(described_class).to_not have_received(:refresh) }
    end
  end

  describe '.refresh' do
    subject { described_class.refresh }

    let(:response) { double(:response, body: response_body, success?: success) }
    let(:response_body) { double(:token, token: 'JuebgKb1pab') }
    let(:configs) { double(:configs, partner_id: 'ID1234', partner_secret: 'Secret134', redis_url: nil) }

    before do
      allow(described_class).to receive(:request).and_return(response)
      allow(Finicity).to receive(:configs).and_return(configs)
    end

    context 'successful response' do
      let(:success) { true }
      let(:method) { :post }
      let(:endpoint) { '/v2/partners/authentication' }
      let(:body) { { partner_id: configs.partner_id, partner_secret: configs.partner_secret } }

      before { subject }

      it { expect(described_class).to have_received(:request).with(method, endpoint, body: body) }
      it { expect(redis['finicity-token']).to eq('JuebgKb1pab') }
      it { expect(Time.parse(redis['finicity-token-expires-at']).future?).to be_truthy }
    end

    context 'failed response' do
      let(:success) { false }

      it { expect { subject }.to raise_error(Finicity::TokenRefreshError) }
    end
  end
end
