module Finicity
  module Resources
    class Transaction < Base
      def list(from:, to:, params: {})
        endpoint = "/v3/customers/#{customer_id}/transactions"
        query = { from_date: from.to_time.to_i, to_date: to.to_time.to_i }.merge(params)

        request(:get, endpoint, query: query)
      end

      def list_for_account(account_id, from:, to:, params: {})
        endpoint = "/v3/customers/#{customer_id}/accounts/#{account_id}/transactions"
        query = { from_date: from.to_time.to_i, to_date: to.to_time.to_i }.merge(params)

        request(:get, endpoint, query: query)
      end

      def load_historic(account_id)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic"

        request(:post, endpoint)
      end

      def load_historic_mfa(account_id, mfa_session, questions)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}/transactions/historic/mfa"
        headers = { "MFA-Session" => mfa_session }
        body = { questions: questions }

        request(:post, endpoint, body: body, headers: headers)
      end
    end
  end
end
