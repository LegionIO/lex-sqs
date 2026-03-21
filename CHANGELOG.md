# Changelog

## [0.1.0] - 2026-03-21

### Added
- Initial release of lex-sqs AWS SQS integration
- `Helpers::Client` — builds `Aws::SQS::Client` with region and credential support
- `Runners::Queues` — `list_queues`, `create_queue`, `delete_queue`, `get_queue_attributes`, `get_queue_url`
- `Runners::Messages` — `send_message`, `receive_messages`, `delete_message`, `purge_queue`, `send_message_batch`
- Standalone `Client` class for use outside the Legion framework
