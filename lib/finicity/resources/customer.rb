module Finicity
  module Resources
    class Customer < Base
      # E.g. Finicity.customer.add(username: 'test@example.com', firstName: 'Test', lastName: 'User')
      def self.add(username:, firstName:, lastName:)
        request(
          :post,
          "/aggregation/v1/customers/#{Finicity.configs.app_type}",
          body: { username: username, firstName: firstName, lastName: lastName }
        )
      end

      # E.g. Finicity.customer.list(search: 'jake')
      #      Finicity.customer.list(username: 'exact-username')
      # Some other options at https://community.finicity.com/s/article/201703219-Customers#get_customers
      def self.list(query = {})
        query = { query: query } if query.present?

        request(:get, '/aggregation/v1/customers', query)
      end

      # E.g. Finicity.scope(10001).delete
      def delete
        request(:delete, "/aggregation/v1/customers/#{customer_id}")
      end
    end
  end
end
