Geocoder.configure(
  timeout: 5,                 # geocoding service timeout (secs)
  units: :mi,                 # :km for kilometers or :mi for miles
  lookup: :nominatim          # name of geocoding service (symbol)
)
