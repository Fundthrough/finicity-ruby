require "finicity/resources/base"
require "finicity/resources/institution"
require "finicity/resources/customer"
require "finicity/resources/account"
require "finicity/resources/transaction"
require "finicity/resources/connect_url"

module Finicity
  class Client
    attr_reader :customer_id

    def self.scope(customer_id)
      new(customer_id)
    end

    def self.customer
      Finicity::Resources::Customer
    end

    def self.institution
      Finicity::Resources::Institution
    end

    def self.connect_url
      Finicity::Resources::ConnectUrl
    end

    def customer
      @customer ||= Finicity::Resources::Customer.new(customer_id)
    end

    def account
      @account ||= Finicity::Resources::Account.new(customer_id)
    end

    def transaction
      @transaction ||= Finicity::Resources::Transaction.new(customer_id)
    end

    def connect_url
      @connect_url ||= Finicity::Resources::ConnectUrl.new(customer_id)
    end

    protected

    def initialize(customer_id)
      @customer_id = customer_id
    end
  end
end
