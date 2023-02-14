module Finicity
  module Resources
    class Institution < Base
      def self.list(query = {})
        endpoint = "/aggregation/v2/institutions"
        query = { query: query } if query.present?

        request(:get, endpoint, query)
      end

      def self.get_branding(institution_id)
        endpoint = "/institution/v2/institutions/#{institution_id}/branding"
        request(:get, endpoint)
      end

      def self.get(institution_id)
        endpoint = "/aggregation/v2/institutions/#{institution_id}/details"
        request(:get, endpoint)
      end
    end
  end
end
