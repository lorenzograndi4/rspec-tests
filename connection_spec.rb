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
      expect(RestClient.get(url).code).to eq(200) # have_http_status(200)
    end

    # it "does not get timeout error" do
    #   response_500 = stub_request(:get, uri).to_timeout
    #   response_200 = stub_request(:get, uri).to_return(headers: {status: 200})
    #   net_req = Net::HTTP.get('www.marinetraffic.com', '/en/ais/details/ships/shipid:4199684/mmsi:244670249/vessel:STORMALONG')
    #   expect(response_200).to have_requested(:get, uri).with(headers: {status: 200})
    # end

end
