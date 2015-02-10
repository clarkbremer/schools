require 'geokit'

class School < ActiveRecord::Base
  has_many :rates, dependent: :destroy

  def num_seniors
    rate_num("four year", "All Students", "All Students", "TOTAL")
  end

  def rate_num(name, group, description, status)
    rate = rates.select { |r| r.name == name && r.group == group && r.description.start_with?(description) && r.status == status }
    rate ? rate.first.num : ""
  end

  def rate_percent(name, group, description, status)
    rate = rates.select { |r| r.name == name && r.group == group && r.description.start_with?(description) && r.status == status }
    rate ? rate.first.percent : ""
  end

  def group_percent(name, group, description)
    ((rate_num(name, group, description, "TOTAL").to_f / rate_num(name, "All Students", "All Students", "TOTAL").to_i)*100).round(2)
  end

  def distance_to(other)
    loc = Geokit::GeoLoc.new(lat: lat, lng: long)
    loc.distance_to(other)
  end
end
