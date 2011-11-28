class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :events, :friends

  def events
    @event = Event.new
  end

  def friends
    @friend = Friend.new
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
