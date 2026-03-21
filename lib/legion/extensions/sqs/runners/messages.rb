# frozen_string_literal: true

module Legion
  module Extensions
    module Sqs
      module Runners
        module Messages
          def send_message(queue_url:, message_body:, delay_seconds: 0, **)
            resp = sqs_client(**).send_message(
              queue_url:     queue_url,
              message_body:  message_body,
              delay_seconds: delay_seconds
            )
            resp.to_h
          end

          def receive_messages(queue_url:, max_number: 10, wait_time: 0, **)
            resp = sqs_client(**).receive_message(
              queue_url:              queue_url,
              max_number_of_messages: max_number,
              wait_time_seconds:      wait_time
            )
            { messages: resp.messages.map(&:to_h) }
          end

          def delete_message(queue_url:, receipt_handle:, **)
            sqs_client(**).delete_message(
              queue_url:      queue_url,
              receipt_handle: receipt_handle
            )
            { deleted: true, receipt_handle: receipt_handle }
          end

          def purge_queue(queue_url:, **)
            sqs_client(**).purge_queue(queue_url: queue_url)
            { purged: true, queue_url: queue_url }
          end

          def send_message_batch(queue_url:, entries:, **)
            resp = sqs_client(**).send_message_batch(
              queue_url: queue_url,
              entries:   entries
            )
            resp.to_h
          end
        end
      end
    end
  end
end
