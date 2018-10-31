require "spec_helper"

describe Finicity::Resources::Customer do
  let(:api_fetcher) { Finicity::Fetchers::API }

  before { allow(api_fetcher).to receive(:request) }

  describe ".create" do
    let(:method) { :post }
    let(:endpoint) { "/aggregation/v1/customers/testing" }
    let(:body) { { first_name: 'Test', last_name: 'User', username: '3137023c8d12' } }
    let(:configs) { double(:configs, app_type: :testing) }

    before do
      allow(Finicity).to receive(:configs).and_return(configs)
      described_class.create(first_name: 'Test', last_name: 'User', username: '3137023c8d12')
    end

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body) }
  end

  describe ".list" do
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/customers" }
    let(:query) { { type: "testing" } }

    context "with query" do
      before { described_class.list(query) }

      it { expect(api_fetcher).to have_received(:request).with(method, endpoint, query: query) }
    end

    context "with no query" do
      before { described_class.list }

      it { expect(api_fetcher).to have_received(:request).with(method, endpoint, {}) }
    end
  end

  describe "#delete" do
    let(:customer_id) { "94857126" }
    let(:method) { :delete }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}" }

    before { described_class.new(customer_id).delete }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end
end
