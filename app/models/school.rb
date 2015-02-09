require 'geokit'

class School < ActiveRecord::Base
  has_many :rates, dependent: :destroy

  def num_seniors
    rate_num("four year", "All Students", "TOTAL")
  end

  def rate_num(name, group, status)
    rates.where(name: name, group: group, status: status).first.num
  end

  def rate_percent(name, group, status)
    rates.where(name: name, group: group, status: status).first.percent
  end

  def distance_to(other)
    loc = Geokit::GeoLoc.new(lat: lat, lng: long)
    loc.distance_to(other)
  end
end
