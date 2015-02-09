
class SchoolsController < ApplicationController
  def index
    puts "@@@@ index:"
    @masp = Geokit::Geocoders::GoogleGeocoder.geocode '2500 Central Ave NE, Minneapolis, MN'
    @schools = School.includes(:rates).where(rates: {group: "All Students"})
    #@schools = School.first(100)
    @schools = @schools.sort_by {|s| s.distance_to(@masp)}
  end

  def show
    @school = School.find(params[:id])
  end

end
