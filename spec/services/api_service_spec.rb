require 'rails_helper'

RSpec.describe ApiService do
  # allow_any_instance_of(Iterable).to receive(:track_event).and_return(true)
  # allow_any_instance_of(Iterable).to receive(:send_email).and_return(true)

  let(:user) { FactoryBot.create(:user) }
  let(:event_a) { FactoryBot.create(:event, user: user, event_type: 'A') }
  let(:event_b) { FactoryBot.create(:event, user: user, event_type: 'B') }

  describe '#initialize' do
    
    it 'sets event and user attributes' do
      allow_any_instance_of(Iterable).to receive(:track_event).and_return(true)
      allow_any_instance_of(Iterable).to receive(:send_email).and_return(true)
      api_service = ApiService.new(event_a.id)

      expect(api_service.event).to eq(event_a)
      expect(api_service.user).to eq(user)
    end

    it 'handles non-existent event' do
      api_service = ApiService.new(-1)  # Non-existent event ID

      expect(api_service.event).to be_nil
      expect(api_service.user).to be_nil
    end
  end

  describe '#trigger_event' do
    context 'when event is present' do
      let(:iterable_instance) { instance_double(Iterable) }

      before do
        allow(Iterable).to receive(:new).and_return(iterable_instance)
        allow(iterable_instance).to receive(:track_event)
        allow(iterable_instance).to receive(:send_email)
      end

      it 'triggers event tracking for Event A' do
        api_service = ApiService.new(event_a.id)

        expect(iterable_instance).to receive(:track_event)
        api_service.trigger_event
      end

      it 'triggers event tracking for Event B' do
        api_service = ApiService.new(event_b.id)

        expect(iterable_instance).to receive(:track_event)
        api_service.trigger_event
      end

      it 'does not sends email for Event A' do
        api_service = ApiService.new(event_a.id)

        expect(iterable_instance).not_to receive(:send_email)
        api_service.trigger_event
      end

      it 'sends email for Event B' do
        api_service = ApiService.new(event_b.id)

        expect(iterable_instance).to receive(:send_email)
        api_service.trigger_event
      end
    end

    context 'when event is not present' do
      it 'does not trigger event tracking' do
        api_service = ApiService.new(-1)  # Non-existent event ID

        expect(api_service.trigger_event).to be_nil
      end
    end
  end
end