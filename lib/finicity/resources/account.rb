module Finicity
  module Resources
    class Account < Base
      def add_all(institution_id, credentials)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall",
          body: { credentials: credentials }
        )
      end

      def add_all_mfa(institution_id, mfa_session, questions)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall/mfa",
          body: { mfa_challenges: { questions: questions } },
          headers: { 'MFA-Session' => mfa_session }
        )
      end

      # E.g. Finicity::Client.scope(10001).account.list
      def list
        request(:get, "/aggregation/v1/customers/#{customer_id}/accounts")
      end

      def activate(institution_id, accounts)
        request(
          :put,
          "/aggregation/v2/customers/#{customer_id}/institutions/#{institution_id}/accounts",
          body: { accounts: accounts }
        )
      end

      def refresh(institution_login_id)
        request(:post, "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts")
      end

      def refresh_mfa(institution_login_id, mfa_session, questions)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts/mfa",
          body: { questions: questions },
          headers: { "MFA-Session" => mfa_session }
        )
      end

      def get(account_id)
        request(:get, "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}")
      end

      def delete(account_id)
        request(:delete, "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}")
      end

      def credentials(account_id)
        request(:get, "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/loginForm")
      end

      def update_credentials(institution_login_id, credentials)
        request(
          :put,
          "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}",
          body: { login_form: credentials }
        )
      end

      # E.g. Finicity::Client.scope(10001).account.enable_txpush(1, 'https://example.com/redirect')
      def enable_txpush(account_id, webhook_url)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/txpush",
          body: { callback_url: webhook_url }
        )
      end

      def disable_txpush(account_id)
        request(:delete, "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/txpush")
      end

      # Only for test accounts
      # E.g. Finicity::Client.scope(10001).account.add_test_transaction(1, {...})
      def add_test_transaction(account_id, transaction_body)
        request(
          :post,
          "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/transactions",
          body: transaction_body
        )
      end
    end
  end
end
