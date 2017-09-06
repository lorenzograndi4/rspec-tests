require_relative 'code'
require 'rspec'

RSpec.describe "When importing lat and lng" do

  it "checks the page is not empty" do
    expect(import_file).not_to be(nil), "The file is empty"
  end

  it "temp" do
    puts find_full_string
  end

  it "checks you find the correct css on page" do
    full_page = import_file
    expect(full_page.css('.details_data_link')).not_to be nil
  end

  it "returns lat and lng" do
    lat, lng = save_as_float
    expect(lat).to be_between(-90, 90)
    expect(lng).to be_between(-180, 180)
  end
end
