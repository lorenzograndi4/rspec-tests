require_relative 'code'
require 'rspec'
require 'webmock/rspec'
require 'rest-client'

RSpec.describe "Test the connection" do

    url = 'https://www.marinetraffic.com/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG'

    it 'returns error if timeout' do
      stub_request(:any, url).to_timeout
      expect{ RestClient.get(url) }.to raise_error(RestClient::Exceptions::OpenTimeout)
    end

    it 'returns 500 if internal server error' do
      stub_request(:any, url).to_return(status: 500, body: 'The request returns an internal server error')
      expect{ RestClient.get(url) }.to raise_error(RestClient::InternalServerError)
    end

    it 'returns 200 if ok' do
      stub_request(:get, url).to_return(status: 200, body: 'The request was successful')
      expect(RestClient.get(url).code).to eq(200)
    end

    it 'checks your actual connection is working' do
      WebMock.allow_net_connect!
      response = RestClient.get(url)
      expect(response.code).to eq(200)
    end
end
