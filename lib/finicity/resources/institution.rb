module Finicity
  module Resources
    class Institution < Base
      class << self

        # E.g. FC.institution.list(search: 'mohela')
        def list(query = {})
          query = { query: query } if query.present?
          request(:get, '/aggregation/v1/institutions', query)
        end

        # E.g. FC.institution.get(101988)
        def get(institution_id)
          request(:get, "/aggregation/v1/institutions/#{institution_id}/details")
        end
      end
    end
  end
end
