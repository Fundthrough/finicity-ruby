module Finicity
  module Resources
    class Consumer < Base

      # E.g. Finicity::Client.scope(10001).consumer.create({...})
      # Look at https://community.finicity.com/s/article/Report-Consumers#create_consumer for required body options
      def create(body)
        request(:post, "/decisioning/v1/customers/#{customer_id}/consumer", body: body)
      end

      # E.g. Finicity::Client.scope(10001).consumer.get
      def get
        request(:get, "/decisioning/v1/customers/#{customer_id}/consumer")
      end

      # E.g. Finicity::Client.scope(10001).consumer.get_connect_link(
      #        partner_id: 1111,
      #        type: 'aggregation',
      #        redirect_uri: 'https://example.com/redirect'
      #      )
      def get_connect_link(
        partner_id:,
        type:,
        redirect_uri:,
        webhook: nil,
        webhook_content_type: nil,
        institution_id: nil
      )
        body = {
          customerId: customer_id.to_s,
          partnerId: partner_id.to_s,
          type: type,
          redirectUri: redirect_uri
        }
        body[:webhook] = webhook if webhook
        body[:webhookContentType] = webhook_content_type if webhook_content_type

        # Only needed when type == 'lite'
        body[:institutionId] = institution_id if institution_id

        request(:post, '/connect/v1/generate', body: body)
      end
    end
  end
end
