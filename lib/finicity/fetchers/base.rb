require "httparty"

module Finicity
  module Fetchers
    class Base
      include HTTParty

      base_uri "https://api.finicity.com/aggregation"
      headers "Content-Type" => "application/json"
      headers "Accept" => "application/json"
      headers "Finicity-App-Key" => Finicity.configs.app_key
      debug_output $stdout if Finicity.configs.verbose

      class << self
        def request(method, endpoint, opts = {})
          tries = 0
          loop do
            begin
              break fetch(method, endpoint, opts)
            rescue Net::ReadTimeout, Errno::ECONNREFUSED, Net::OpenTimeout => e
              raise e if (tries += 1) > Finicity.configs.max_retries.to_i
            end
          end
        end

        protected

        def fetch(method, endpoint, opts)
          request_opts = normalize_request_options(opts)

          response = send(method, endpoint, request_opts)

          raise Finicity::ApiServerError, response.body if server_error?(response)

          Hashie::Mash.new(
            success?:    response.success?,
            status_code: response.code,
            body:        parse_json(response.body),
            headers:     response.headers
          )
        end

        def normalize_request_options(opts)
          opts.clone.tap do |o|
            o[:headers] = default_headers.merge(o[:headers].to_h)
            o[:body]    = jsonify(o[:body]) if o[:body].present?
            o[:query]   = camelcase_keys(o[:query]) if o[:query].present?
          end
        end

        def parse_json(body)
          result = JSON.parse(body.to_s).deep_transform_keys!(&:underscore)
          Hashie::Mash.new(result)
        rescue JSON::ParserError
          body
        end

        def jsonify(body)
          camelcase_keys(body).to_json
        end

        def camelcase_keys(hash)
          hash.deep_transform_keys! { |k| k.to_s.camelcase(:lower) }
        end

        def server_error?(response)
          other_content_type?(response)
        end

        def other_content_type?(response)
          content_type = response.headers["Content-Type"]&.downcase
          content_type.present? && content_type != "application/json"
        end

        def default_headers
          {}
        end
      end
    end
  end
end
