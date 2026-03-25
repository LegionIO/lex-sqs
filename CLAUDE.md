# lex-sqs: AWS SQS Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to AWS SQS. Provides runners for queue management and message operations (send, receive, delete, batch).

**GitHub**: https://github.com/LegionIO/lex-sqs
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Sqs
├── Runners/
│   ├── Queues    # list_queues, create_queue, delete_queue, get_queue_attributes, get_queue_url
│   └── Messages  # send_message, receive_messages, delete_message, purge_queue, send_message_batch
├── Helpers/
│   └── Client    # Aws::SQS::Client factory (region + credentials)
└── Client        # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/sqs.rb` | Entry point, extension registration |
| `lib/legion/extensions/sqs/runners/queues.rb` | Queue management runners |
| `lib/legion/extensions/sqs/runners/messages.rb` | Message send/receive/delete runners |
| `lib/legion/extensions/sqs/helpers/client.rb` | Aws::SQS::Client factory |
| `lib/legion/extensions/sqs/client.rb` | Standalone Client class |

## Authentication

AWS credentials via `access_key_id:`, `secret_access_key:`, and `region:` kwargs. Alternatively uses the standard AWS credential chain (env vars, instance profile, etc.) if not provided explicitly.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `aws-sdk-sqs` (~> 1.0) | AWS SQS Ruby SDK |

## Development

21 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
