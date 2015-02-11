
class SchoolsController < ApplicationController
  def index
    @title = "Minnesota Public High Schools"
    @masp = Geokit::Geocoders::GoogleGeocoder.geocode '2500 Central Ave NE, Minneapolis, MN'
    @schools = School.includes(:rates).where(rates: {group: "All Students"})
    if params[:commit] == "Filter on size"
      @min_size = params[:min_size].to_i
      @max_size =  params[:max_size].to_i
      @schools = @schools.reject {|s| s.num_seniors > @max_size } if @max_size != 0
      @schools = @schools.reject {|s| s.num_seniors < @min_size } if @min_size
    end
  end

  def show
    @school = School.find(params[:id])
    @title = "Graduation Status for All Students"
  end

  def gender
    @school = School.find(params[:school_id])
    @title = "Gender Details"
  end

  def ethnicity
    @school = School.find(params[:school_id])
    @title = "Ethnicity Details"
  end

  def special
    @school = School.find(params[:school_id])
    @title = "Special Needs Details"
  end

end
