# -*- coding: utf-8 -*-
require "open-uri"
class Event < ActiveRecord::Base
  def get_latlng
    open("http://maps.google.com/maps/api/geocode/json?sensor=false&address=" + ERB::Util.u(self.address)) do |result|
      location = ActiveSupport::JSON.decode(result)["results"].first["geometry"]["location"]
      self.latitude = location["lat"]
      self.longitude = location["lng"]
    end
  end
end
