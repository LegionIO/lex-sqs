# frozen_string_literal: true

require 'aws-sdk-sqs'

module Legion
  module Extensions
    module Sqs
      module Helpers
        module Client
          def sqs_client(region: 'us-east-1', access_key_id: nil, secret_access_key: nil, **_opts)
            config = { region: region }
            config[:access_key_id] = access_key_id if access_key_id
            config[:secret_access_key] = secret_access_key if secret_access_key
            Aws::SQS::Client.new(**config)
          end
        end
      end
    end
  end
end
