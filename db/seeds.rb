# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'
require 'httparty'
require 'geocoder'

file = File.join(Rails.root, "db", "breweries_us.csv")
CSV.foreach(file) do |row|
  name = row[0]
  # p name
  bar_type = row[1]
  # p type
  address = row[2]
  # p website
  # website = row[3]
  # p address
  state = row[4]
  # p state

  cleaned_address = address.gsub("\u00A0", ' ')
  address = URI.encode_www_form_component(cleaned_address)
  begin
    response = HTTParty.get("https://api.mapbox.com/search/geocode/v6/forward?q=https://api.mapbox.com/search/geocode/v6/forward?q=#{address}&access_token=pk.eyJ1IjoianVzdGlubW9yZ2FuMjEiLCJhIjoiY20yZTY5a2xwMWl6ajJqb21ndHJxZGxtMiJ9.DNPxCkDT6qG3oIK_Zuq-ng")

    if response.success?
      data = JSON.parse(response.body)
      brewery_coords = data["features"][0]["geometry"]["coordinates"]
      p "Longitude: " + brewery_coords[0].to_s
      p "Latitude: " + brewery_coords[1].to_s
      long = brewery_coords[0]
      lat = brewery_coords[1]
      Brewery.create(name: name, bar_type: bar_type, address: address, state: state, lat: lat, long: long)
    else
      puts "Request failed"
    end
  rescue ArgumentError, JSON::ParserError => e
    puts "Error: address not formatted properly for mapbox get request. #{e.message}"
    Brewery.create(name: name, bar_type: bar_type, address: address, state: state)
  rescue StandardError => e
    puts "Error: address not formatted properly for mapbox get request. #{e.message}"
    Brewery.create(name: name, bar_type: bar_type, address: address, state: state)
  end
end