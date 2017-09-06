require 'open-uri'
require 'nokogiri'

def import_file
  Nokogiri::HTML(open("https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG"))
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

def save_as_float
  split_lat_lng.map { |item| item.to_f }
end

# puts save_as_float

# expect(response).to be_success # ??
# expect(rendered).to have_content 'Stormalong' # ??
# expect(actual).to be_within(delta).of(expected)
