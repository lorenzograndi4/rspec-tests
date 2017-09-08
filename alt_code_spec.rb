require_relative 'alt_code'
require 'rspec'

RSpec.describe "When importing lat and lng" do
  it "returns error if it does not find HTML" do
    
    expect(select_inner_string).to be_an_instance_of(Nokogiri::HTML::Document)
  end

  it "returns one value if we split using wrong divider" do
    array = find_array('1.1° / 9.9°', '&')
    expect(array.length).to eq(1)
  end

  it "returns error if you get only one value" do
    find_position = find_lat_lng(['33'])
    puts find_position
    expect(find_position).to eq(@error)
  end

  it "returns error if lat / lng are not numbers" do
    find_position = find_lat_lng(['foo', 'bar'])
    puts find_position
    expect(find_position).to eq(@error)
  end

  it "shouldn't be too far from the previous position" do
    prev_lat, prev_lng = find_lat_lng
    sleep 2 # change this to whatever value makes sense
    current_lat, current_lng = find_lat_lng
    expect(current_lat).to be_within(0.2).of(prev_lat)
    expect(current_lng).to be_within(0.2).of(prev_lng)
  end

  it "lat and lng exist in the world" do
    # the example we wrote together
    lat, lng = find_lat_lng
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end
end
