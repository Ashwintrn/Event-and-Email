require 'net/http'
require 'uri'
require 'json'

class Iterable
  API_KEY = ENV.fetch('API_KEY')
  TRACK_EVENT_URL = "https://api.iterable.com/api/events/track"
  EMAIL_URL = "https://api.iterable.com/api/email/target"

  def initialize(event_type, user_email, event_id)
    @params = {event_type: event_type, user_email: user_email, campaign_id: event_id}
  end

  def track_event
    uri = URI.parse(TRACK_EVENT_URL)
    send_request(uri, form_track_event_data)
  end

  def send_email
    uri = URI.parse(EMAIL_URL)
    send_request(uri, form_send_email_data)
  end

  private

  def send_request(uri, body_data)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request['Authorization'] = "Bearer #{API_KEY}"
    request.body = body_data.to_json

    response = http.request(request)
    if response.code == 200
      Rails.logger.info "The Request for #{uri.path} was success"
    else
      Rails.logger.error "The Request for #{uri.path} was returned with code:#{response.code}"
    end
    
  end

  def form_track_event_data
    {
      "email": @params[:user_email],
      "eventName": @params[:event_type]
    }
  end

  def form_send_email_data
    {
      "campaignId": @params[:campaign_id],
      "recipientEmail": @params[:user_email]
    }
  end
end