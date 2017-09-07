require_relative 'code'
require 'rspec'

def random_lat
  rand(0..90).to_f
end

def random_lng
  rand(0..180).to_f
end

RSpec.describe "When importing lat and lng" do

  it "checks the page is not empty" do
    expect(import_file).not_to be(nil), "The file is empty"
  end

  it "checks the page is an HTML doc" do
    expect(import_file.class).to eq(Nokogiri::HTML::Document)
  end

  it "checks the page contains the lat_lng string" do
    expect(import_file.to_s).to include('Latitude / Longitude')
  end

  it "checks you find the correct css on page" do
    expect(import_file.css('.details_data_link')).not_to be nil
    expect(import_file.css('.details_data_link').to_s).to include('°')
  end

  it "checks you select a string from the page" do
    expect(select_inner_string).to be_an_instance_of(String)
  end

  it "checks you get only 2 values" do
    expect(find_lat_lng.length).to eq(2)
  end

  it "returns lat and lng from page" do
    lat, lng = find_lat_lng
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end

  it "returns error if lat / lng are not numbers" do
    find_position = find_lat_lng(['foo', 'bar'])
    puts find_position
    expect(find_position).to eq(@error)
  end

  it "shouldn't be too far from the previous position" do
    prev_lat, prev_lng = find_lat_lng
    sleep 10
    current_lat, current_lng = find_lat_lng
    expect(current_lat).to be_within(2).of(prev_lat)
    expect(current_lng).to be_within(2).of(prev_lng)
  end

  it "checks lat and lng for random values" do
    expect(random_lat).to be_between(-90, 90)
    expect(random_lng).to be_between(-180, 180)
  end
end
