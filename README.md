# lex-sqs

Legion Extension for AWS SQS integration. Provides queue management and message operations.

## Installation

Add to your Gemfile:

```ruby
gem 'lex-sqs'
```

## Usage

### Standalone client

```ruby
require 'legion/extensions/sqs'

client = Legion::Extensions::Sqs::Client.new(
  region:            'us-east-1',
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)

client.list_queues
client.send_message(queue_url: 'https://sqs.us-east-1.amazonaws.com/123/my-queue', message_body: 'hello')
client.receive_messages(queue_url: 'https://sqs.us-east-1.amazonaws.com/123/my-queue', max_number: 5)
```

## Runners

- `Queues`: `list_queues`, `create_queue`, `delete_queue`, `get_queue_attributes`, `get_queue_url`
- `Messages`: `send_message`, `receive_messages`, `delete_message`, `purge_queue`, `send_message_batch`

## License

MIT
