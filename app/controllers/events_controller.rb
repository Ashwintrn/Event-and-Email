class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.save!
      redirect_to action: :index
    else
      redirect_to action: :index
    end 
  end

  private
    def event_params
      params.require(:event).permit!
    end
end
