class BreweriesController < ApplicationController
  require 'httparty'
  def nearby

    # breweries = Brewery.all
    # p breweries[2000]
    # breweries.each { |b|
    #   @brewery = b
    #   if !@brewery.lat
    #     p @brewery.address
    #     cleaned_address = @brewery.address.gsub("\u00A0", ' ')
    #     address = URI.encode_www_form_component(cleaned_address)
    #     response = HTTParty.get("https://api.mapbox.com/search/geocode/v6/forward?q=https://api.mapbox.com/search/geocode/v6/forward?q=#{address}&access_token=pk.eyJ1IjoianVzdGlubW9yZ2FuMjEiLCJhIjoiY20yZTY5a2xwMWl6ajJqb21ndHJxZGxtMiJ9.DNPxCkDT6qG3oIK_Zuq-ng")


    #     # 448%20W.%2016th%20St.,%20New%20York

    #     if response.success?
    #       data = JSON.parse(response.body)
    #       brewery_coords = data["features"][0]["geometry"]["coordinates"]
    #       # p "Longitude: " + brewery_coords[0].to_s
    #       # p "Latitude: " + brewery_coords[1].to_s
    #       @brewery.long = brewery_coords[0]
    #       @brewery.lat = brewery_coords[1]
    #       # brewery.save
    #       @brewery.save
    #       # dist = distance(coordinates, brewery_coords)
    #       # p dist
          
    #     else
    #       puts "Request failed"
    #     end
    #   end
    # }



    # p "Params"
    # p params[:coordinates]
    @breweries = Brewery.closest(Brewery.all, params[:coordinates])
    # p @breweries
    render :index
  end

  def index
    @breweries = Brewery.all
    render :index
  end
end
