require "spec_helper"

describe Finicity::Resources::Account do
  subject { described_class.new(customer_id) }

  let(:customer_id) { "839548210" }
  let(:institution_id) { "12003" }
  let(:account_id) { "149128850" }
  let(:institution_login_id) { "183612985858" }

  let(:api_fetcher) { Finicity::Fetchers::API }

  before { allow(api_fetcher).to receive(:request) }

  describe "#add_all" do
    let(:credentials) { [{ name: "username", value: "house" }, { name: "password", value: "pass" }] }
    let(:method) { :post }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall" }
    let(:body) { { credentials: credentials } }

    before { subject.add_all(institution_id, credentials) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body) }
  end

  describe "#add_all_mfa" do
    let(:mfa_session) { "14rEngx9aNpw39Qenf" }
    let(:questions) { [{ text: "small world?", answer: "sure" }] }
    let(:method) { :post }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall/mfa" }
    let(:body) { { mfa_challenges: { questions: questions } } }
    let(:headers) { { "MFA-Session" => mfa_session } }

    before { subject.add_all_mfa(institution_id, mfa_session, questions) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body, headers: headers) }
  end

  describe "#list" do
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/accounts" }

    before { subject.list }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#activate" do
    let(:method) { :put }
    let(:endpoint) { "/aggregation/v2/customers/#{customer_id}/institutions/#{institution_id}/accounts" }
    let(:accounts) { [{ id: 12, type: :loan }] }
    let(:body) { { accounts: accounts } }

    before { subject.activate(institution_id, accounts) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body) }
  end

  describe "#refresh" do
    let(:method) { :post }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts" }

    before { subject.refresh(institution_login_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#refresh_mfa" do
    let(:mfa_session) { "14rEngx9aNpw39Qenf" }
    let(:questions) { [{ text: "after all this time?", answer: "always" }] }
    let(:method) { :post }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts/mfa" }
    let(:body) { { questions: questions } }
    let(:headers) { { "MFA-Session" => mfa_session } }

    before { subject.refresh_mfa(institution_login_id, mfa_session, questions) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body, headers: headers) }
  end

  describe "#get" do
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}" }

    before { subject.get(account_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#delete" do
    let(:method) { :delete }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}" }

    before { subject.delete(account_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#credentials" do
    let(:method) { :get }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/loginForm" }

    before { subject.credentials(account_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#update_credentials" do
    let(:method) { :put }
    let(:endpoint) { "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}" }
    let(:credentials) { [{ name: "username", value: "house" }, { name: "password", value: "pass" }] }
    let(:body) { { login_form: credentials } }

    before { subject.update_credentials(institution_login_id, credentials) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body) }
  end

  describe "#owner_verification" do
    let(:method) { :get }
    let(:endpoint) { "/decisioning/v1/customers/#{customer_id}/accounts/#{account_id}/owner" }

    before { subject.owner_verification(account_id) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint) }
  end

  describe "#owner_verification_mfa" do
    let(:method) { :post }
    let(:mfa_session) { "14rEngx9aNpw39Qenf" }
    let(:questions) { [{ text: "small world?", answer: "sure" }] }
    let(:endpoint) { "/decisioning/v1/customers/#{customer_id}/accounts/#{account_id}/owner/mfa" }
    let(:body) { { questions: questions } }
    let(:headers) { { "MFA-Session" => mfa_session } }

    before { subject.owner_verification_mfa(account_id, mfa_session, questions) }

    it { expect(api_fetcher).to have_received(:request).with(method, endpoint, body: body, headers: headers) }
  end
end
