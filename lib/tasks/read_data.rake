require 'geokit'
require 'csv'

task :read_data => :environment do

  @addresses = {}
  rows = CSV.read(Rails.root.join("data", "addresses.csv"))
  rows.each do |cols|
    name = cols[4].tr('"', '')
    district_number = cols[0].tr('"', '').rjust(4, '0')
    district_type = cols[1].tr('"', '').rjust(2, '0')
    school_number = cols[2].tr('"', '').rjust(3, '0')
    code = "#{district_number}-#{district_type}-#{school_number}"
    street = cols[16].tr('"', '')
    city = cols[18].tr('"', '')
    state = cols[19].tr('"', '')
    unless @addresses.key? code
      @addresses[code] = "#{street}, #{city}, #{state}"
    end
  end

  School.destroy_all
  rows = CSV.read(Rails.root.join("data", "2013 Graduation Indicators.csv"))
  rows.each do |cols|
  #  break if School.count > 10
    district_number = cols[3]
    district_type = cols[4]
    school_number = cols[6]
    code = "#{district_number}-#{district_type}-#{school_number}"
    school = School.where(code: code).first_or_create
    school.name = cols[7].strip if school.name.blank?

    school.rates.create(
      name: "four year",
      num: cols[12].to_i,
      percent: cols[13].to_f,
      group: cols[8],
      desc: cols[10],
      status: cols[11],
      code: code
    )
    school.rates.create(
      name: "five year",
      num: cols[14].to_i,
      percent: cols[15].to_f,
      group: cols[8],
      desc: cols[10],
      status: cols[11],
      code: code
    )
    school.rates.create(
      name: "six year",
      num: cols[16].to_i,
      percent: cols[17].to_f,
      group: cols[8],
      desc: cols[10],
      status: cols[11],
      code: code
    )
    if school.address.blank?
      if @addresses.key? code
        school.address = @addresses[code]
        unless @addresses[code] == 'unknown'
          loc = Geokit::Geocoders::GoogleGeocoder.geocode (@addresses[code])
          school.lat = loc.lat
          school.long = loc.lng
          puts "location of #{school.name}(#{school.code}): #{school.lat}, #{school.long}"
        end
      else
        school.address = "unknown"
      end
    end
    school.save!
  end

  file=File.open(Rails.root.join("data", "GettingPrepared2014Appendices.csv"), "r:ISO-8859-1")
  rows = CSV.parse(file)
  puts "#{rows.count} rows in remediation csv"
  rows.each do |cols|
    code = cols[2]
    year = cols[3]
    percent = cols[10].to_f
    num = cols[8].to_i
    if year == "2012"
      school = School.where(code: code).first
      if school
        school.rates.create(
          name: "remediation_rate",
          num: num,
          percent: percent,
          group: "All Students",
          status: "remediation",
          code: code
        )
        puts "Added remediation_rate of #{percent} to #{school.name}"
      end
    end
  end

end
