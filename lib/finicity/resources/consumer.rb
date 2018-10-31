module Finicity
  module Resources
    class Consumer < Base

      # E.g. Finicity::Client.scope(10001).consumer.create
      def create
        request(:post, "/decisioning/v1/customers/#{customer_id}/consumer")
      end

      # E.g. Finicity::Client.scope(10001).consumer.get
      def get
        request(:get, "/decisioning/v1/customers/#{customer_id}/consumer")
      end
    end
  end
end
