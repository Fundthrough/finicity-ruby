module Finicity
  module Resources
    class Account < Base
      def add_all(institution_id, credentials)
        endpoint = "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall"
        body = { credentials: credentials }

        request(:post, endpoint, body: body)
      end

      def add_all_mfa(institution_id, mfa_session, questions)
        endpoint = "/aggregation/v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/addall/mfa"
        body = { mfa_challenges: { questions: questions } }
        headers = { "MFA-Session" => mfa_session }

        request(:post, endpoint, body: body, headers: headers)
      end

      def list
        endpoint = "/aggregation/v1/customers/#{customer_id}/accounts"

        request(:get, endpoint)
      end

      def activate(institution_id, accounts)
        endpoint = "/aggregation/v2/customers/#{customer_id}/institutions/#{institution_id}/accounts"

        request(:put, endpoint, body: { accounts: accounts })
      end

      def refresh(institution_login_id)
        endpoint = "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts"

        request(:post, endpoint)
      end

      def refresh_mfa(institution_login_id, mfa_session, questions)
        endpoint = "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}/accounts/mfa"

        body =  { questions: questions }
        headers = { "MFA-Session" => mfa_session }

        request(:post, endpoint, body: body, headers: headers)
      end

      def owner(account_id)
        endpoint = "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/owner"
        request(:get, endpoint)
      end

      def details(account_id)
        endpoint = "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/details"
        request(:get, endpoint)
      end

      def get(account_id)
        endpoint = "/aggregation/v2/customers/#{customer_id}/accounts/#{account_id}"

        request(:get, endpoint)
      end

      def delete(account_id)
        endpoint = "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}"

        request(:delete, endpoint)
      end

      def credentials(account_id)
        endpoint = "/aggregation/v1/customers/#{customer_id}/accounts/#{account_id}/loginForm"

        request(:get, endpoint)
      end

      def update_credentials(institution_login_id, credentials)
        endpoint = "/aggregation/v1/customers/#{customer_id}/institutionLogins/#{institution_login_id}"
        body = { login_form: credentials }

        request(:put, endpoint, body: body)
      end

      def owner_verification(account_id)
        endpoint = "/decisioning/v1/customers/#{customer_id}/accounts/#{account_id}/owner"

        request(:get, endpoint)
      end

      def owner_verification_mfa(account_id, mfa_session, questions)
        endpoint = "/decisioning/v1/customers/#{customer_id}/accounts/#{account_id}/owner/mfa"

        body = { questions: questions }
        headers = { "MFA-Session" => mfa_session }

        request(:post, endpoint, body: body, headers: headers)
      end
    end
  end
end
