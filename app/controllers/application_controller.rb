class ApplicationController < ActionController::Base
  before_action :set_sidebar_events

  private

  def set_sidebar_events
    @events = Event.where(start: Date.today.beginning_of_week..Date.today.end_of_week)
  end
end
