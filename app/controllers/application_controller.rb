class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :events

  def events
    @event = Event.new
  end
end
