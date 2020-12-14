class LandingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "landing_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
