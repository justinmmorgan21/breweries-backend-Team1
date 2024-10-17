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

file = File.join(Rails.root, "db", "breweries_us.csv")
CSV.foreach(file) do |row|
  name = row[0]
  # p name
  bar_type = row[1]
  # p type
  website = row[2]
  # p website
  address = row[3]
  # p address
  state = row[4]
  # p state
  Brewery.create(name: name, bar_type: bar_type, address: address, state: state)
end