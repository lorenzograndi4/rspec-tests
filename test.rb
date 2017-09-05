require 'open-uri'
require 'nokogiri'
require 'rspec'

def import_file
  Nokogiri::HTML(open("https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG"))
end

def extrapolate
  import_file.css('.details_data_link')[0].children.text
end

def divide_lat_lng
  extrapolate.gsub(/[\ °]/,"").split('/')
end

def save_as_float
  divide_lat_lng.map { |item| item.to_f }
end

RSpec.describe "find lat and lng" do
  it "returns lat and lng" do
    lat, lng = save_as_float
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end
end
