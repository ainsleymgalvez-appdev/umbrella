p "Where are you located?"

user_location = gets.chomp

# p user_location = "200 S Wacker"

require "open-uri"
require "json"

full_url = "https://maps.googleapis.com/maps/api/geocode/json?address=UIC&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

subbed_string = full_url.gsub("UIC", user_location)

raw_gmaps_data = URI.open(subbed_string).read

#JSON Part

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat").to_s
longitude = loc.fetch("lng").to_s

# DARK SKY PART

weather_url = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/#{latitude},#{longitude}"

# wlat_string = weather_url.gsub("27.1751448", latitude)

# wlon_string = weather_url.gsub("78.0421422", longitude)

full_raw_weather = URI.open(weather_url).read

# JSON Start

parsed_weather_data = JSON.parse(full_raw_weather)

weather_results_array = parsed_weather_data.fetch("currently")

weather_summary = weather_results_array.fetch("summary")
weather_degrees = weather_results_array.fetch("temperature")

p "It is currently " + weather_degrees.to_s + " degrees and " + weather_summary + " in " + user_location + "!"
