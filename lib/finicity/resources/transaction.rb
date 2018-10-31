module Finicity
  module Resources
    class Transaction < Base

      # E.g. FC.scope(10001).transaction.list(from: 6.months.ago, to: Date.current)
      # Few other options at https://community.finicity.com/s/article/202460245-Transactions#get_customer_transactions_v3
      def list(from:, to:, params: {})
        request(
          :get,
          "/aggregation/v3/customers/#{customer_id}/transactions",
          query: { from_date: from.to_time.to_i, to_date: to.to_time.to_i }.merge(params)
        )
      end

      # E.g. FC.scope(10001).transaction.list_for_account(1, from: 6.months.ago, to: Date.current)
      # Other options: https://community.finicity.com/s/article/202460245-Transactions#get_customer_account_transactions_v3
      def list_for_account(account_id, from:, to:, params: {})
        request(
          :get,
          "/aggregation/v3/customers/#{customer_id}/accounts/#{account_id}/transactions",
          query: { from_date: from.to_time.to_i, to_date: to.to_time.to_i }.merge(params)
        )
      end

      # E.g. FC.scope(10001).transaction.load_historic(1)
      def load_historic(account_id)
        request(:post, "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic")
      end


      def load_historic_mfa(account_id, mfa_session, questions)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic/mfa",
          body: { questions: questions },
          headers: { 'MFA-Session' => mfa_session }
        )
      end
    end
  end
end
