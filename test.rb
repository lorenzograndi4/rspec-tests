require 'open-uri'
require 'nokogiri'
require 'rspec'
require 'rails-helper'
# require 'rspec-expectations'

doc = Nokogiri::HTML(open("https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG"))

def find_lat_lng(doc)
  string = doc.css('.details_data_link')[0].children.text
  lat_lng = string.gsub(/[\ °]/,"").split('/')
  lat_lng.map do |item|
    item.to_f
  end
end

RSpec.describe "find lat and lng" do
  it "returns lat and lng" do
    lat, lng = find_lat_lng
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end
end
