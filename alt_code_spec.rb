require_relative 'alt_code'
require 'rspec'
require 'webmock/rspec'
require 'open-uri'
# require 'rest-client'

RSpec.describe "When importing lat and lng" do

  url = 'https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG'

  # it "returns custom error message when an error occurs" do
  #   check_timeout = WebMock.stub_request(:get, url).to_timeout
  #   puts check_timeout
  #   expect(find_string(check_timeout)).to include('manually')
  # end

  it 'returns error if timeout' do
    check_timeout = WebMock.stub_request(:get, url).to_timeout
    puts check_timeout
    expect{ find_string(check_timeout) }.to raise_error(StandardError)
  end

  it 'returns error if 500' do
    check_500 = WebMock.stub_request(:get, url).to_return(status: 500, body: 'Something')
    expect{ find_string(check_500) }.to raise_error(StandardError)
  end

  it 'returns error if 404' do
    check_404 = WebMock.stub_request(:get, url).to_return(status: 404, body: 'Something')
    expect{ find_string(check_404) }.to raise_error(StandardError)
  end

  it "returns error if no HTML is found" do
    expect{ find_string('Not HTML') }.to raise_error(NoMethodError)
  end

  it "returns only one value if we split using wrong divider" do
    array = find_array('1.1° / 9.9°', '&')
    expect(array.length).to eq(1)
  end

  # this is connected to the previous one
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
    WebMock.allow_net_connect!
    prev_lat, prev_lng = find_lat_lng
    sleep 10 # change this to whatever value makes sense
    current_lat, current_lng = find_lat_lng
    expect(current_lat).to be_within(0.2).of(prev_lat)
    expect(current_lng).to be_within(0.2).of(prev_lng)
  end

  it "returns error if lat is out of limits" do
    lat_lng = find_lat_lng(['99.9', '22.2'])
    puts lat_lng
    expect(lat_lng).to eq(@error)
  end

  it "returns error if lng is out of limits" do
    lat_lng = find_lat_lng(['11.1', '-199.9'])
    puts lat_lng
    expect(lat_lng).to eq(@error)
  end

  it "checks lat and lng exist in the world" do
    WebMock.allow_net_connect!
    # the example we wrote together
    lat, lng = find_lat_lng
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end
end
