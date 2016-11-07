module Finicity
  module Resources
    class Account < Base
      def add_all(institution_id, credentials)
        endpoint = "/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall"
        body = { credentials: credentials }

        request(:post, endpoint, body: body)
      end

      def add_all_mfa(institution_id, mfa_session, questions)
        endpoint = "/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall/mfa"
        body = { mfa_challenges: { questions: questions } }
        headers = { 'MFA-Session' => mfa_session }

        request(:post, endpoint, body: body, headers: headers)
      end

      def list
        endpoint = "/v1/customers/#{customer_id}/accounts"

        request(:get, endpoint)
      end

      def activate(institution_id, accounts)
        endpoint = "/v2/customers/#{customer_id}/institutions/#{institution_id}/accounts"

        request(:put, endpoint, body: { accounts: accounts })
      end

      def refresh(institution_login_id)
        endpoint = "/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts"

        request(:post, endpoint)
      end

      def refresh_mfa(institution_login_id, mfa_session, questions)
        endpoint = "/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts/mfa"

        body =  { questions: questions }
        headers = { 'MFA-Session' => mfa_session }

        request(:post, endpoint, body: body, headers: headers)
      end

      def get(account_id)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}"

        request(:get, endpoint)
      end

      def delete(account_id)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}"

        request(:delete, endpoint)
      end

      def credentials(account_id)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}/loginForm"

        request(:get, endpoint)
      end

      def update_credentials(account_id, credentials)
        endpoint = "/v1/customers/#{customer_id}/accounts/#{account_id}/loginForm"
        body = { login_form: credentials }

        request(:put, endpoint, body: body)
      end
    end
  end
end
