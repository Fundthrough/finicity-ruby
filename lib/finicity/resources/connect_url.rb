module Finicity
  module Resources
    class ConnectUrl < Base
      def generate_lite_url(institution_id, redirect_url, webhook_url)
        endpoint = "/connect/v2/generate/lite"

        body = {
          institutionId: institution_id,
          customerId: customer_id,
          partnerId: Finicity.configs.partner_id,
          redirectUri: redirect_url,
          webhook: webhook_url,
          webhookContentType: 'application/json'
        }

        request(:post, endpoint, body: body)
      end
    end
  end
end