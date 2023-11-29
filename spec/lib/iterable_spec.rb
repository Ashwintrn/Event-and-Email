# spec/lib/iterable_spec.rb

require 'rails_helper'
require 'webmock/rspec'
require_relative '../../lib/iterable'

RSpec.describe Iterable do
  let(:user) { FactoryBot.create(:user) }
  let(:event_a) { FactoryBot.create(:event, user: user, event_type: 'A') }
  let(:event_b) { FactoryBot.create(:event, user: user, event_type: 'B') }
  let(:iterable_event_a) { Iterable.new(event_a.event_type, user.email, event_a.id) }
  let(:iterable_event_b) { Iterable.new(event_b.event_type, user.email, event_b.id) }
  let(:track_event_url) { 'https://api.iterable.com/api/events/track' }
  let(:email_url) { 'https://api.iterable.com/api/email/target' }

  before do
    allow(ENV).to receive(:fetch).with('api_key').and_return('dummy_api_key')
  end

  describe '#track_event' do
    context 'when event_type is "Event A"' do
      it 'makes a POST request to track Event A' do
        stub_request(:post, track_event_url)
          .with(
            headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer dummy_api_key' },
            body: { email: user.email, eventName: 'A' }.to_json
          )
          .to_return(status: 200, body: '{}', headers: {})

        iterable_event_a.track_event
      end
    end

    context 'when event_type is "Event B"' do
      it 'makes a POST request to track Event B' do
        stub_request(:post, track_event_url)
          .with(
            headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer dummy_api_key' },
            body: { email: user.email, eventName: 'B' }.to_json
          )
          .to_return(status: 200, body: '{}', headers: {})

        iterable_event_b.track_event
      end
    end
  end

  describe '#send_email' do
    context 'when event_type is "Event A"' do
      it 'makes a POST request to send an email for Event A' do
        stub_request(:post, email_url)
          .with(
            headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer dummy_api_key' },
            body: { campaignId: event_a.id, recipientEmail: user.email }.to_json
          )
          .to_return(status: 200, body: '{}', headers: {})

        iterable_event_a.send_email
      end
    end

    context 'when event_type is "Event B"' do
      it 'makes a POST request to send an email for Event B' do
        stub_request(:post, email_url)
          .with(
            headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer dummy_api_key' },
            body: { campaignId: event_b.id, recipientEmail: user.email }.to_json
          )
          .to_return(status: 200, body: '{}', headers: {})

        iterable_event_b.send_email
      end
    end
  end
end