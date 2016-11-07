require "spec_helper"

describe Finicity::Fetchers::Base do
  let(:method) { :post }
  let(:endpoint) { "/v1/customers" }
  let(:opts) { { body: request_body, headers: request_headers, query: query } }
  let(:request_body) { { customer: { username: "Batman", first_name: "Bruce", last_name: "Wayne" } } }
  let(:request_headers) { { "Custom-Header" => "1294854" } }
  let(:query) { { type: "active" } }
  let(:response) { double(:response, body: body, headers: headers, code: code, success?: true) }
  let(:body) { "{\"customer\":{\"id\":\"8989412304\"}}" }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:code) { 200 }
  let(:configs) { double(:configs, app_key: "key", max_retries: 1, verbose: false) }

  before { allow(Finicity).to receive(:configs).and_return(configs) }

  describe ".request" do
    subject { described_class.request(method, endpoint, opts) }

    context "with connection errors" do
      let(:error) { double }

      context "Connection error" do
        before { allow(error).to receive(:headers).and_raise(Net::ReadTimeout) }

        context "return error only after one try" do
          before { allow(described_class).to receive(method).and_return(error, response) }

          it { expect { subject }.to_not raise_error }
        end

        context "return error after two tries" do
          before { allow(described_class).to receive(method).and_return(error, error, response) }

          it { expect { subject }.to raise_error(Net::ReadTimeout) }
        end
      end

      context "Server error" do
        let(:headers) { { "Content-Type" => "text/html" } }

        before { allow(described_class).to receive(:post).and_return(response) }

        it { expect { subject }.to raise_error(Finicity::ApiServerError) }
      end
    end

    context "without connection errors" do
      let(:request_opts) { { body: json_body, headers: request_headers, query: query } }
      let(:json_body) { "{\"customer\":{\"username\":\"Batman\",\"firstName\":\"Bruce\",\"lastName\":\"Wayne\"}}" }

      before do
        allow(described_class).to receive(method).and_return(response)
        subject
      end

      context "with json response" do
        it { expect(described_class).to have_received(:post).with(endpoint, request_opts) }
        it { expect(subject.success?).to be_truthy }
        it { expect(subject.status_code).to eq(200) }
        it { expect(subject.body).to be_kind_of(Hashie::Mash) }
        it { expect(subject.body.customer.id).to eq("8989412304") }
        it { expect(subject.headers).to eq(headers) }
      end

      context "with string response" do
        let(:body) { "Customer already created" }

        it { expect(subject.body).to eq(body) }
      end
    end
  end
end
