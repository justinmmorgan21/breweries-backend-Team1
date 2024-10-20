class Brewery < ApplicationRecord
  require 'httparty'
  require 'geocoder'
  def self.closest(breweries, coordinates)
    p coordinates
    closest = []
    breweries.each{ |brewery|
      brewery_coords = [brewery.long, brewery.lat]
      if brewery.long && brewery.lat
        dist = distance(coordinates, brewery_coords)
        if closest.length < 5
          closest << {brewery: brewery, distance: dist}
          closest.sort_by!{|brewery| brewery[:distance]}
        else
          if dist < closest[4][:distance]
            closest[4] = {brewery: brewery, distance: dist}
            closest.sort_by!{|brewery| brewery[:distance]}
          end
        end
      end
    }
    # pp closest
    closest.map!{ |hash| 
      hash[:brewery]
    }
    closest
    # p breweries[1500]
    # p "lat"
    # p breweries[1500].lat
    # p "long"
    # p breweries[1500].long
    # brewery_coords = [breweries[1500].long, breweries[1500].lat]
    # dist = distance(coordinates, brewery_coords)
    # p dist
  end

  def self.distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters
  
    dlat_rad = (loc2[0].to_f-loc1[0].to_f) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1].to_f-loc1[1].to_f) * rad_per_deg
  
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
  
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad.to_f) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    a = a.abs
    # a = Math.abs(a)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  
    rm * c / 1609.34  # Delta in miles
  end

end
