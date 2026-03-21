# frozen_string_literal: true

RSpec.describe Legion::Extensions::Sqs::Runners::Messages do
  let(:mock_sqs) { instance_double(Aws::SQS::Client) }
  let(:client) { Legion::Extensions::Sqs::Client.new }
  let(:queue_url) { 'https://sqs.us-east-1.amazonaws.com/123/my-queue' }

  before do
    allow(Aws::SQS::Client).to receive(:new).and_return(mock_sqs)
  end

  describe '#send_message' do
    it 'sends a message and returns the response hash' do
      resp = double(to_h: { message_id: 'msg-123', md5_of_message_body: 'abc123' })
      expect(mock_sqs).to receive(:send_message).with(
        queue_url:     queue_url,
        message_body:  'hello',
        delay_seconds: 0
      ).and_return(resp)
      result = client.send_message(queue_url: queue_url, message_body: 'hello')
      expect(result[:message_id]).to eq('msg-123')
    end

    it 'accepts a custom delay_seconds' do
      resp = double(to_h: { message_id: 'msg-456' })
      expect(mock_sqs).to receive(:send_message).with(
        queue_url:     queue_url,
        message_body:  'delayed',
        delay_seconds: 30
      ).and_return(resp)
      client.send_message(queue_url: queue_url, message_body: 'delayed', delay_seconds: 30)
    end
  end

  describe '#receive_messages' do
    it 'returns a list of messages' do
      msg = double(to_h: { message_id: 'msg-1', body: 'hello', receipt_handle: 'rh-1' })
      expect(mock_sqs).to receive(:receive_message).with(
        queue_url:              queue_url,
        max_number_of_messages: 10,
        wait_time_seconds:      0
      ).and_return(double(messages: [msg]))
      result = client.receive_messages(queue_url: queue_url)
      expect(result[:messages].size).to eq(1)
      expect(result[:messages].first[:message_id]).to eq('msg-1')
    end

    it 'accepts custom max_number and wait_time' do
      expect(mock_sqs).to receive(:receive_message).with(
        queue_url:              queue_url,
        max_number_of_messages: 5,
        wait_time_seconds:      20
      ).and_return(double(messages: []))
      result = client.receive_messages(queue_url: queue_url, max_number: 5, wait_time: 20)
      expect(result[:messages]).to be_empty
    end
  end

  describe '#delete_message' do
    it 'deletes a message and returns confirmation' do
      receipt_handle = 'rh-abc'
      expect(mock_sqs).to receive(:delete_message).with(
        queue_url:      queue_url,
        receipt_handle: receipt_handle
      )
      result = client.delete_message(queue_url: queue_url, receipt_handle: receipt_handle)
      expect(result[:deleted]).to be true
      expect(result[:receipt_handle]).to eq(receipt_handle)
    end
  end

  describe '#purge_queue' do
    it 'purges a queue and returns confirmation' do
      expect(mock_sqs).to receive(:purge_queue).with(queue_url: queue_url)
      result = client.purge_queue(queue_url: queue_url)
      expect(result[:purged]).to be true
      expect(result[:queue_url]).to eq(queue_url)
    end
  end

  describe '#send_message_batch' do
    it 'sends a batch of messages and returns response hash' do
      entries = [
        { id: '1', message_body: 'msg1' },
        { id: '2', message_body: 'msg2' }
      ]
      resp = double(to_h: { successful: entries, failed: [] })
      expect(mock_sqs).to receive(:send_message_batch).with(
        queue_url: queue_url,
        entries:   entries
      ).and_return(resp)
      result = client.send_message_batch(queue_url: queue_url, entries: entries)
      expect(result[:failed]).to be_empty
    end
  end
end
