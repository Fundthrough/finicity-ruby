require "spec_helper"

describe Finicity::Resources::Transaction do
  subject { described_class.new(customer_id) }

  let(:customer_id) { "839548210" }
  let(:account_id) { "149128850" }
  let(:from_date) { 6.months.ago }
  let(:to_date) { Time.now }

  let(:api_fetcher) { Finicity::Fetchers::API }

  before { allow(api_fetcher).to receive(:request) }

  describe "#list" do
    let(:method) { :get }
    let(:endpoint) { "/v2/customers/#{customer_id}/transactions" }
    let(:query) { { from_date: from_date.to_i, to_date: to_date.to_i, page: 2 } }

    before { subject.list(from: from_date, to: to_date, params: { page: 2 }) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, query: query) }
  end

  describe "#list_for_account" do
    let(:method) { :get }
    let(:endpoint) { "/v2/customers/#{customer_id}/accounts/#{account_id}/transactions" }
    let(:query) { { from_date: from_date.to_i, to_date: to_date.to_i, page: 2 } }

    before { subject.list_for_account(account_id, from: from_date, to: to_date, params: { page: 2 }) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, query: query) }
  end

  describe "#load_historic" do
    let(:method) { :post }
    let(:endpoint) { "/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic" }

    before { subject.load_historic(account_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#load_historic_mfa" do
    let(:mfa_session) { "14rEngx9aNpw39Qenf" }
    let(:questions) { [{ text: "have a bullet?", answer: "in your head" }] }
    let(:method) { :post }
    let(:endpoint) { "/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic/mfa" }
    let(:body) { { questions: questions } }
    let(:headers) { { "MFA-Session" => mfa_session } }

    before { subject.load_historic_mfa(account_id, mfa_session, questions) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body, headers: headers) }
  end
end
