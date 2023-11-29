class ApiService
  # This Service acts as a bridge between the action and the iterable, and makes it loosely coupled
  # Later if needed we can extend this to use other API services like swagger, etc 
  attr_accessor :event, :user

  def initialize(event_id)
    @event = Event.find_by_id(event_id)
    @user = User.find_by_id(@event.user_id) if @event.present?
  end

  def trigger_event
    if @event.present?
      iterable_obj = Iterable.new(@event.event_type, user.email, @event.id)
      iterable_obj.track_event
      iterable_obj.send_email if @event.event_type == "B"
    end
  end
end