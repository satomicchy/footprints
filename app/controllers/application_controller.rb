class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :events, :friends

  def events
    @event = Event.new
  end

  def friends
    @friend = Friend.new
  end
end
