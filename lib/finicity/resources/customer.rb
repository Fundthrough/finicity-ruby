module Finicity
  module Resources
    class Customer < Base
      # E.g. Finicity.customer.create(username: 'test@example.com', first_name: 'Test', last_name: 'User')
      def self.create(username:, first_name:, last_name:)
        request(
          :post,
          "/aggregation/v1/customers/#{Finicity.configs.app_type}",
          body: { username: username, firstName: first_name, lastName: last_name }
        )
      end

      # E.g. Finicity.customer.list(search: 'jake')
      #      Finicity.customer.list(username: 'exact-username')
      # Some other options at https://community.finicity.com/s/article/201703219-Customers#get_customers
      def self.list(query = {})
        query = { query: query } if query.present?

        request(:get, '/aggregation/v1/customers', query)
      end

      # E.g. Finicity.scope(10001).customer.delete
      def delete
        request(:delete, "/aggregation/v1/customers/#{customer_id}")
      end

      # Non-interactive accounts refresh for customer. See "Refresh Customer Accounts (non-interactive)"
      # https://developer.finicity.com/admin/docs
      #
      # E.g. Finicity::Client.scope(10001).customer.refresh
      def refresh
        request(:post, "/aggregation/v1/customers/#{customer_id}/accounts")
      end
    end
  end
end
