# frozen_string_literal: true

require 'legion/extensions/sqs/version'
require 'legion/extensions/sqs/helpers/client'
require 'legion/extensions/sqs/runners/queues'
require 'legion/extensions/sqs/runners/messages'
require 'legion/extensions/sqs/client'

module Legion
  module Extensions
    module Sqs
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
