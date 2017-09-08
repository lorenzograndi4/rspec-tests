require 'open-uri'
require 'nokogiri'

def scrape_page (
  url = 'http://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG'
  )
  open(url)
end

def find_string (
  opened_url = scrape_page,
  css_selector = '.details_data_link'
  )
  # no need to break this one into smaller methods
  # bc we test the interface, not the implementation
  Nokogiri::HTML(opened_url).css(css_selector)[0].children.text
end

def find_array (
  string = find_string,
  divider = '/'
)
  # no need to break the 2 methods
  string.gsub(/[\ °]/,"").split(divider)
end

def find_lat_lng (
  clean_string_array = find_array
  )

  lat_lng_float = clean_string_array.map(&:to_f) # shorter way to write it

  case
    # in this case we are ~almost certainly~ converting something wrong to float
    when lat_lng_float == [0.0, 0.0]
      @error = "An error occurred:\nLat and Lng are not numbers.\nPlease enter Lat and Lng manually."
      return @error
    # in this case we only received one value (wrong divider?)
    when lat_lng_float.length < 2
      @error = "An error occurred:\nWe got only one value instead of two.\nPlease enter Lat and Lng manually."
      return @error
    # in this case lat is out of the world's limits
    when lat_lng_float[0] > 90 || lat_lng_float[0] < -90
      @error = "An error occurred:\nThe Lat value is not correct.\nPlease enter Lat and Lng manually."
      return @error
    # in this case lng is out of the world's limits
    when lat_lng_float[1] > 180 || lat_lng_float[1] < -180
      @error = "An error occurred:\nThe Lng value is not correct.\nPlease enter Lat and Lng manually."
      return @error
    else
      lat_lng_float
    end
end

begin
  result = find_lat_lng
# This is where I catch all the StandardErrors and print them for whoever runs the code
rescue => error_message
  puts "An error occurred:\n#{error_message}\nPlease enter Lat and Lng manually."
else
  puts result
end
