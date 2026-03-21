# frozen_string_literal: true

RSpec.describe Legion::Extensions::Sqs::Runners::Queues do
  let(:mock_sqs) { instance_double(Aws::SQS::Client) }
  let(:client) { Legion::Extensions::Sqs::Client.new }

  before do
    allow(Aws::SQS::Client).to receive(:new).and_return(mock_sqs)
  end

  describe '#list_queues' do
    it 'returns a list of queue URLs' do
      allow(mock_sqs).to receive(:list_queues).and_return(
        double(queue_urls: ['https://sqs.us-east-1.amazonaws.com/123/my-queue'])
      )
      result = client.list_queues
      expect(result[:queue_urls].size).to eq(1)
      expect(result[:queue_urls].first).to include('my-queue')
    end

    it 'returns empty list when no queues' do
      allow(mock_sqs).to receive(:list_queues).and_return(double(queue_urls: []))
      result = client.list_queues
      expect(result[:queue_urls]).to be_empty
    end
  end

  describe '#create_queue' do
    it 'creates a queue and returns the URL' do
      expect(mock_sqs).to receive(:create_queue).with(queue_name: 'my-queue').and_return(
        double(queue_url: 'https://sqs.us-east-1.amazonaws.com/123/my-queue')
      )
      result = client.create_queue(queue_name: 'my-queue')
      expect(result[:queue_url]).to include('my-queue')
    end

    it 'passes attributes when provided' do
      expect(mock_sqs).to receive(:create_queue).with(
        queue_name: 'my-queue',
        attributes: { 'VisibilityTimeout' => '60' }
      ).and_return(double(queue_url: 'https://sqs.us-east-1.amazonaws.com/123/my-queue'))
      client.create_queue(queue_name: 'my-queue', attributes: { 'VisibilityTimeout' => '60' })
    end
  end

  describe '#delete_queue' do
    it 'deletes a queue and returns confirmation' do
      queue_url = 'https://sqs.us-east-1.amazonaws.com/123/my-queue'
      expect(mock_sqs).to receive(:delete_queue).with(queue_url: queue_url)
      result = client.delete_queue(queue_url: queue_url)
      expect(result[:deleted]).to be true
      expect(result[:queue_url]).to eq(queue_url)
    end
  end

  describe '#get_queue_attributes' do
    it 'returns queue attributes' do
      queue_url = 'https://sqs.us-east-1.amazonaws.com/123/my-queue'
      expect(mock_sqs).to receive(:get_queue_attributes).with(
        queue_url:       queue_url,
        attribute_names: ['All']
      ).and_return(double(attributes: { 'ApproximateNumberOfMessages' => '5' }))
      result = client.get_queue_attributes(queue_url: queue_url)
      expect(result[:attributes]['ApproximateNumberOfMessages']).to eq('5')
    end

    it 'accepts custom attribute names' do
      queue_url = 'https://sqs.us-east-1.amazonaws.com/123/my-queue'
      expect(mock_sqs).to receive(:get_queue_attributes).with(
        queue_url:       queue_url,
        attribute_names: ['ApproximateNumberOfMessages']
      ).and_return(double(attributes: { 'ApproximateNumberOfMessages' => '0' }))
      client.get_queue_attributes(queue_url: queue_url, attribute_names: ['ApproximateNumberOfMessages'])
    end
  end

  describe '#get_queue_url' do
    it 'returns the queue URL for a given name' do
      expect(mock_sqs).to receive(:get_queue_url).with(queue_name: 'my-queue').and_return(
        double(queue_url: 'https://sqs.us-east-1.amazonaws.com/123/my-queue')
      )
      result = client.get_queue_url(queue_name: 'my-queue')
      expect(result[:queue_url]).to include('my-queue')
    end
  end
end
