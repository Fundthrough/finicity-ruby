module Finicity
  module Resources
    class ConnectUrl < Base
      def self.v2_url
      end

      def self.v2_lite_url(institution_id, params: {})
        endpoint = "/connect/v2/generate/lite"

        body = {
          institutionId: institution_id,
          customerId: customer_id
        }

        request(:post, endpoint, body: body)
      end
    end
  end
end