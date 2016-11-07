module Finicity
  module Resources
    class Institution < Base
      def self.list(query = {})
        endpoint = '/v1/institutions'
        query = { query: query } if query.present?

        request(:get, endpoint, query)
      end

      def self.get(institution_id)
        endpoint = "/v1/institutions/#{institution_id}/details"

        request(:get, endpoint)
      end
    end
  end
end
