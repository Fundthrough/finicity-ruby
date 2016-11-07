require "spec_helper"

describe Finicity::Client do
  subject { described_class.new(customer_id) }

  let(:customer_id) { "8359892" }

  describe ".scope" do
    it { expect(described_class.scope(customer_id)).to be_instance_of(described_class) }
    it { expect(described_class.scope(customer_id).customer_id).to eq(customer_id) }
  end

  describe ".customer" do
    it { expect(described_class.customer).to eq(Finicity::Resources::Customer) }
  end

  describe ".institution" do
    it { expect(described_class.institution).to eq(Finicity::Resources::Institution) }
  end

  describe "#customer" do
    it { expect(subject.customer).to be_instance_of(Finicity::Resources::Customer) }
    it { expect(subject.customer.customer_id).to eq(customer_id) }
  end

  describe "#account" do
    it { expect(subject.account).to be_instance_of(Finicity::Resources::Account) }
    it { expect(subject.account.customer_id).to eq(customer_id) }
  end

  describe "#transaction" do
    it { expect(subject.transaction).to be_instance_of(Finicity::Resources::Transaction) }
    it { expect(subject.transaction.customer_id).to eq(customer_id) }
  end
end
