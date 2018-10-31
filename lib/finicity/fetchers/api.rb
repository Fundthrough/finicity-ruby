require 'finicity/fetchers/token'

module Finicity
  module Fetchers
    class API < Base
      class << self
        def request(*args)
          response = super(*args)

          return response if !invalid_app_token?(response)

          app_token.refresh
          request(*args)
        end

        protected

        def invalid_app_token?(response)
          response.status_code == 401 && INVALID_APP_TOKEN_CODES.include?(response.body&.code)
        end

        def default_headers
          { 'Finicity-App-Token' => app_token.get }
        end

        def app_token
          ::Finicity::Fetchers::Token
        end
      end
    end
  end
end
