# frozen_string_literal: true

module Legion
  module Extensions
    module Sqs
      module Runners
        module Queues
          def list_queues(**)
            resp = sqs_client(**).list_queues
            { queue_urls: resp.queue_urls }
          end

          def create_queue(queue_name:, **opts)
            conn_opts = opts.slice(:region, :access_key_id, :secret_access_key)
            queue_opts = opts.except(:region, :access_key_id, :secret_access_key)
            params = { queue_name: queue_name }
            params[:attributes] = queue_opts[:attributes] if queue_opts[:attributes]
            resp = sqs_client(**conn_opts).create_queue(**params)
            { queue_url: resp.queue_url }
          end

          def delete_queue(queue_url:, **)
            sqs_client(**).delete_queue(queue_url: queue_url)
            { deleted: true, queue_url: queue_url }
          end

          def get_queue_attributes(queue_url:, attribute_names: ['All'], **)
            resp = sqs_client(**).get_queue_attributes(
              queue_url:       queue_url,
              attribute_names: attribute_names
            )
            { queue_url: queue_url, attributes: resp.attributes }
          end

          def get_queue_url(queue_name:, **)
            resp = sqs_client(**).get_queue_url(queue_name: queue_name)
            { queue_url: resp.queue_url }
          end
        end
      end
    end
  end
end
