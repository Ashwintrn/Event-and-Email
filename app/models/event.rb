class Event < ApplicationRecord
  belongs_to :user
  after_create :create_event_in_iterable

  private

  def create_event_in_iterable      #this method can be put as ASYNC 
    service_obj = ApiService.new(id)
    service_obj.trigger_event
  end

end
