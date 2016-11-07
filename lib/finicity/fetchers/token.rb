module Finicity
  module Fetchers
    class Token < Base
      class << self
        def get
          refresh if token_expired?
          token
        end

        def refresh
          response = fetch_new_one

          raise Finicity::TokenRefreshError, response.body unless response.success?

          redis["finicity-token-expires-at"] = 90.minutes.from_now.to_s
          redis["finicity-token"] = response.body.token
        end

        protected

        def fetch_new_one
          endpoint = "/v2/partners/authentication"
          body = {
            partner_id: Finicity.configs.partner_id,
            partner_secret: Finicity.configs.partner_secret
          }
          request(:post, endpoint, body: body)
        end

        def token_expired?
          !(token_expired_at.present? && Time.parse(token_expired_at).future?)
        end

        def token
          redis["finicity-token"]
        end

        def token_expired_at
          redis["finicity-token-expires-at"]
        end

        def redis
          Redis.new(url: Finicity.configs.partner_secret)
        end
      end
    end
  end
end
