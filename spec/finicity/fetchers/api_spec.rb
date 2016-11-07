require 'spec_helper'

describe Finicity::Fetchers::API do
  let(:method) { :get }
  let(:endpoint) { '/v1/customers/895786124/accounts' }
  let(:response1) { double(:response, body: { code: code }, headers: headers, code: status_code, success?: true) }
  let(:response2) { response1 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:status_code) { 200 }
  let(:code) { 10_084 }
  let(:token) { ::Finicity::Fetchers::Token }
  let(:request_headers) { { 'Finicity-App-Token' => 'token123abx' } }

  describe '.request' do
    subject { described_class.request(method, endpoint) }

    before do
      allow(described_class).to receive(method).and_return(response1, response2)
      allow(token).to receive(:refresh)
      allow(token).to receive(:get).and_return('token123abx')

      subject
    end

    context 'valid request' do
      it { expect(described_class).to have_received(method).with(endpoint, headers: request_headers) }
      it { expect(token).to_not have_received(:refresh) }
    end

    context 'forbidden request' do
      let(:status_code) { 403 }

      it { expect(described_class).to have_received(method).with(endpoint, headers: request_headers) }
      it { expect(token).to_not have_received(:refresh) }
    end

    context 'unauthorized request with non-matched code' do
      let(:status_code) { 401 }

      it { expect(described_class).to have_received(method).with(endpoint, headers: request_headers) }
      it { expect(token).to_not have_received(:refresh) }
    end

    context 'unauthorized request with matched code' do
      let(:status_code) { 401 }
      let(:code) { 10_022 }
      let(:response2) { double(:response, body: {}, headers: headers, code: 200, success?: true) }

      it { expect(described_class).to have_received(method).with(endpoint, headers: request_headers).twice }
      it { expect(token).to have_received(:refresh) }
    end
  end
end
