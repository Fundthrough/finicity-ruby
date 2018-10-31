require "spec_helper"

describe Finicity::Resources::Institution do
  let(:api_fetcher) { Finicity::Fetchers::API }

  before { allow(api_fetcher).to receive(:request) }

  describe ".list" do
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/institutions" }

    context "with query" do
      before { described_class.list(search: "Canada") }

      it { expect(api_fetcher).to have_received(:request).with(method, endpoint, query: { search: "Canada" }) }
    end

    context "without query" do
      before { described_class.list }

      it { expect(api_fetcher).to have_received(:request).with(method, endpoint, {}) }
    end
  end

  describe ".get" do
    let(:institution_id) { "128594" }
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/institutions/#{institution_id}/details" }

    before { described_class.get(institution_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end
end
