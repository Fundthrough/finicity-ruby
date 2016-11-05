module Finicity
  module Resources
    class Customer < Base
      def self.add(username)
        endpoint = "/v1/customers/#{Finicity.configs.app_type}"
        body = { username: username }

        request(:post, endpoint, body: body)
      end

      def self.list(query = {})
        endpoint = "/v1/customers"
        query = { query: query } if query.present?

        request(:get, endpoint, query)
      end

      def delete
        endpoint = "/v1/customers/#{customer_id}"

        request(:delete, endpoint)
      end
    end
  end
end
