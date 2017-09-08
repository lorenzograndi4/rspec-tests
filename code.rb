require 'open-uri'
require 'nokogiri'

def import_file(url = "https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG")
  open(url) do |f|
    return unless f.status == ["200", "OK"]
  end

  Nokogiri::HTML(open(url))
end

def find_full_string
  import_file.css('.details_data_link')[0]
end

def select_inner_string
  find_full_string.children.text
end

def remove_unwanted_chars
  select_inner_string.gsub(/[\ °]/,"")
end

def split_lat_lng
  remove_unwanted_chars.split('/')
end

def find_lat_lng(argument = split_lat_lng)
  lat_lng = argument.map { |item| item.to_f }
  case lat_lng
    when [0.0, 0.0] # we are ~probably~ converting something wrong to float
      @error = "Lat and Lng are not numbers, something went wrong!"
      return @error
    when !Array
      @error = "This is not an array ;("
      return @error
    else
      lat_lng
    end
end

begin
  puts find_lat_lng
rescue => e # rescue StandardError by default
  puts e # print error as it is
end
