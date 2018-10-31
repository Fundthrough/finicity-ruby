require 'finicity/fetchers'

module Finicity
  module Resources
    class Base
      attr_reader :customer_id

      def initialize(customer_id)
        @customer_id = customer_id
      end

      def self.request(*args)
        ::Finicity::Fetchers::API.request(*args)
      end

      protected

      # TODO: can be combined with .request above
      # Proxy used by the resource classes
      def request(*args)
        self.class.request(*args)
      end
    end
  end
end
